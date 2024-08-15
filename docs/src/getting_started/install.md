# Installation Guide

This page will guide you through:

- Configuring a system with LVM on LUKS.
- Installing NixOS.
- Applying configurations from my flake.

In this guide, ***some values are placeholders***, and you may / should change them if needed:

- The main installation drive is assumed `/dev/sdx`.
  Identify yours with `sudo lsblk`.
- The hostname of the machine is assumed `nixos`.
  You should change it to something more descriptive.
- The working user of the machine is assumed `me`.
  You should change it to something more descriptive.
- The mapped LUKS and LVM devices are `cryptroot` and `lvmroot` respectively.
  This is pretty common, you can leave them as-is.

## Prepare Installation Media

Download the latest [NixOS ISO](https://nixos.org/download/) for your architecture.
The recommended graphical ISO image will do just fine and adds some ease of use.
Even so, we will install from the terminal exclusively, so if you _really_ want _dat minimalism_, go for the
minimal ISO, it's fine.

To flash the USB manually, use `dd`.

```shell
sudo dd if=/path/to/iso of=/dev/sdx bs=4096 status=progress
```

> [!CAUTION]
> Selecting the wrong device might lead to you overwriting your own data!

> [!TIP]
> An alternative to this is to use [Ventoy](https://github.com/ventoy/Ventoy).
> After copying the ISO, remember to run `sync` to make sure all data is written to the drive before unplugging.

Boot into the install ISO and connect to the internet.
Afterwards, open a terminal.

## Disk Formatting

This section covers partitioning for the _single_ main drive on which NixOS will be installed, for sake of simplicity.
If you have other drives you wish to use, you can handle those now as well, but if they are only for extra storage,
and will not hold any system partitions, then you can always configure them later.

> [!CAUTION]
> All the data on this drive will be irrevocably destroyed.
> Make all necessary backups now!
> Be _extra careful_ not to run the commands in this section on the wrong devices, as it may lead to data loss too!

### Partitioning

We will be using full-disk encryption, so we only need two partitions: one for booting, and the rest of the drive.
We'll use `gdisk` for this.

```shell
sudo gdisk /dev/sdx
```

Then do the following:

- View help. (`?`)
- Create a new GPT. (`o`)
- Create a new EFI partition. (`n <default> <default> +1G ef00`)
- Create a new LVM partition for the rest of the drive. (`n <default> <default> <default> 8e00`)
- Save the changes and exit. (`w`)

Running `sudo lsblk` again should show the two partitions as `/dev/sdx1` and `/dev/sdx2`.

### LUKS Encryption

We can now enable full-disk encryption with LUKS via a master password.
There are alternatives, such as dummy USB headers or YubiKeys but let's keep it simple here.

> [!IMPORTANT]
> Forgetting the password for your LUKS container results in a permanent loss of acess to the drive's contents.
> Store it in a safe place, like a password manager.

```shell
sudo cryptsetup -v -y \
    -c aes-xts-plain64 -s 512 -h sha512 -i 4000 --use-random \
    --label=NIXOS_LUKS luksFormat --type luks2 /dev/sdx2
```

An explanation of above options:

- `-v`: Verbose, increases output for debugging in case something goes wrong.
- `-y`: Ask for the password interactively, twice, and ensure their match before proceeding.
- `-c`: Specifies the cypher, in this case `aes-xts-plain64` is also the default for the LUKS2 format.
- `-s`: Specifies the key size used by the cypher.
- `-h`: Specifies the hashing algorith used, `sha256` by default.
- `-i`: Milliseconds to spend processing the passphrase, `2000` by default. Longer is more secure but less convenient.
- `--use-random`: Specifies the more secure RNG source.
- `--label`: Adds a label to the partition so we can reference it easily in configs.
- `luksFormat`: Operation mode that encrypts a partition and sets a passphrase.
- `--type`: Specify the LUKS type to use.
- `/dev/sdx2`: The partition you wish to encrypt.

> [!TIP]
> You can inspect the LUKS header to check everything OK with `sudo cryptsetup luksDump /dev/sdx2`.
> It is also a good practice to back it up.
> Create a copy with `sudo cryptsetup luksHeaderBackup --header-backup-file /a/path/header.img /dev/sdx2`.
> Do so when it is convenient later.

Open the LUKS container so that we can use it.

```shell
sudo cryptsetup open --type luks /dev/sdx2 cryptroot
```

Check the mapped device exists:

```shell
ls /dev/mapper/cryptroot
```

### LVM Partitioning


Create a physical volume, and a volume group within it.

```shell
sudo pvcreate         /dev/mapper/cryptroot
sudo vgcreate lvmroot /dev/mapper/cryptroot
```

Create the logical partitions you want to use, it's up to you how you size them.
I recommend you set aside at least 128G for your root drive to have dedicated breathing room for the `/nix/store`,
match your RAM for the swap, and leave the rest for your home partition.
If you have lots of RAM, or don't plan on using hibernation, you can skip the swap partition entirely, as you
can always create an arbitrary swapfile when in a pinch.

```shell
sudo lvcreate -L16G       lvmroot -n swap
sudo lvcreate -L128G      lvmroot -n root
sudo lvcreate -l 100%FREE lvmroot -n home
```

### Filesystem Formatting

All the partitions are in place, we can now format them with the appropriate filesystems and label them for easy
reference in the configuration.

> [!NOTE]
> Labels should be maximum of 11 bytes for the boot, and 16 bytes for the rest, so keep them short if you want to name
> them differently.

```shell
sudo mkfs.fat  -n NIXOS_BOOT -F32 /dev/sdx1
sudo mkfs.ext4 -L NIXOS_ROOT      /dev/mapper/lvmroot-root
sudo mkfs.ext4 -L NIXOS_HOME      /dev/mapper/lvmroot-home
sudo mkswap    -L NIXOS_SWAP      /dev/mapper/lvmroot-swap
```

### Mounting the Partitions

Mount the partitions inside `/mnt`.

```shell
sudo mount /dev/disk/by-label/NIXOS_ROOT /mnt
sudo mkdir /mnt/boot
sudo mkdir /mnt/home
sudo mount -o umask=0077 /dev/disk/by-label/NIXOS_BOOT /mnt/boot
sudo mount /dev/disk/by-label/NIXOS_HOME /mnt/home
sudo swapon -L NIXOS_SWAP
```

This is how your drive should be partitioned:

```text
# Output of `sudo lsblk -o name,type,mountpoints /dev/sdx`:
NAME               TYPE  MOUNTPOINTS
sdx                disk
├─sdx1             part  /mnt/boot
└─sdx2             part
  └─cryptroot      crypt
    ├─lvmroot-swap lvm   [SWAP]
    ├─lvmroot-root lvm   /mnt
    └─lvmroot-home lvm   /mnt/home
```

## NixOS Bootstrapping

We can now do a fresh install of NixOS.

> [!TIP]
> If you already configured this _exact_ machine before, and just want to do a clean-wipe install, you can skip the
> rest of this guide and install [directly from your flake](#bonus-future-re-installs).

### Minimal OS Configuration

Generate a NixOS config.

```shell
sudo nixos-generate-config --root /mnt
```

In some cases, the scan might not configure the filesystems correctly, especially because we're using LUKS.
We are also missing some minimal basic features to allow us to bootstrap the nixfiles.
Let's edit the configs manually.
I also provide a working example of settings **added** or **changed**.
Do note the rest of the defaults Nix enabled shouldn't be touched _(yet)_.

In `/mnt/etc/nixos/hardware-configuration.nix`, setup the following:

- Add the `cryptd` kernel module for LUKS.
- Define the primary luks device.
- Update the filesystems to use `/dev/disk/by-label` for convenience.
- Enable firmware updates _(optional, recommended)_.

For reference:

```nix
{ config, lib, pkgs, modulesPath, ... }: {
    # ...
    hardware.enableAllFirmware = true;
    boot.initrd.kernelModules = [
        # ...
        "cryptd"
    ];
    boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-label/NIXOS_LUKS";

    fileSystems."/" = {
        device = "/dev/disk/by-label/NIXOS_ROOT";
        fsType = "ext4";
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-label/NIXOS_BOOT";
        fsType = "vfat";
        options = [ "umask=0077" ];
    };

    fileSystems."/home" = {
        device = "/dev/disk/by-label/NIXOS_HOME";
        fsType = "ext4";
    };

    swapDevices = [
        { device = "/dev/disk/by-label/NIXOS_SWAP"; }
    ];
    # ...
}
```

In `/mnt/etc/nixos/configuration.nix`, setup the following:

- Enable flakes.
- Enable networking and set a hostname.
- Create a user for yourself.
- Add `neovim` and `git` to the systemPackages for convenience.
- Allow unfree packages _(optional, recommended)_.

For reference:

```nix
{ config, lib, pkgs, ...}: {
    # ...

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    networking.hostname = "nixos";
    networking.networkmanager.enable = true;

    users.users.me = {
        uid = 1000;
        createHome = true;
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
    };

    environment.systemPackages = with pkgs; [
        # ...
        neovim
        git
    ];

    # ...
}
```

### Install

Install NixOS from the config _(this will take a while)_:

```shell
sudo nixos-install --root /mnt --no-root-passwd
```

Now set the password for the user you created!

```shell
sudo nixos-enter --root /mnt -c 'passwd me'
```

Safely unmount all partitions and reboot:

```shell
sudo umount -R /mnt
sudo swapoff -L NIXOS_SWAP
sudo vgchange -a n lvmroot
sudo cryptsetup close /dev/mapper/cryptroot
reboot
```

## Installing Nixfiles

You should now have a secure base installation of NixOS!
Use this generation as a restore point in case you mess things up.
Now we can install the actual configs from my flake.

### Setting Up the Repo

Clone the repo.
By convention, I do that in `~/repo/nixfiles`.

```shell
mkdir ~/repo
git clone https://github.com/Jadarma/nixfiles.git ~/repo/nixfiles
cd ~/repo/nixfiles
```

### System Definition

Add your system to the file structure by copying over your NixOS configs.
By convention, the pattern is `systems/<arch>/<hostname>`.
For example:

```shell
mkdir -p systems/x86_64-linux/nixos
cp /etc/nixos/*configuration.nix systems/x86_64-linux/nixos
```

You can now rebuild from the flake instead of the `/etc/` configs.
Don't forget to track the files in `git`, otherwise the flake will ignore them.

```shell
git add systems/x86_64-linux/nixos/*
sudo nixos-rebuild switch --flake .#
reboot
```

### Integrating the Nixfiles

We did not change any configs, merely copied them over and used the flake to build them rather than the Nix channels.
The resulting system configuration _should_ be almost identical _(flake will likely pin another nixpkgs version)_.

It's now time to take advantage of the module system.
In my flake, there is a `modules/nixos` for NixOS modules and `modules/home` for HomeManager.
I pick and choose the ones I want to copy over _(usually most of them)_.
You can read through them, and add them to the `imports`, check out other systems in the repo for reference.

> [!NOTE]
> As mentioned previously, this flake is specialized for my use, so many of the modules aren't configurable.
> Rather, they provide defaults or common things I might want to set across all personal devices.

Some of the things we configured previously are covered by my modules, you may remove them from the main config after
importing them.

Oh, and note to self;
the `home/xdg` module might cause the activation to fail because the default NixOS install already configures your home
directory with the same files.
Since I prefer renaming the default user dirs, I get rid of them first:

```shell
rm ~/.config/user-dirs.*
rm -r ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Public ~/Templates ~/Videos
```

After making all desired changes, apply the flake and test once more.

```shell
sudo nixos-rebuild switch --flake .#
reboot
```

Hooray!
Commit your changes to always have them ready.
Speaking of commits, if you are me, remember you can now change to using SSH for the repo if you've enabled the
`git` and `gpg` modules:

```shell
git remote set-url origin git@github.com:Jadarma/nixfiles.git
```

## Cleanup

Now that you have your system in a working, more complete state, we can get rid of the old generations and lingering
config files.

```shell
sudo rm /etc/nixos/*configuration.nix
sudo nix-collect-garbage --delete-old
reboot
```

## Bonus: Future Re-Installs

If, for whatever reason, you want to re-install the system again, you can take massive shortcuts.
Follow the same instructions for disk formatting and mounting.
You can safely delete the whole drive and partition from scratch, as long as you use the same label names!

But instead of doing a normal `nixos-install`, you can instead install directly from the flake, provided it's on a
public Git repository.

> [!NOTE]
> Since this is technically a fresh install, this is an opprtunity to update `system.stateVersion` in your config.
> You can update it for both NixOS and HomeManager to the version of the NixISO you're installing from.
> You can either clone the repo locally to make the quick change, or commit it from a separate machine, it's all just
> declarative configuration after all!
> Or you can also probably leave it alone, you don't have much to lose.

If your flake config doesn't include a hashedPassword for the user, remember to add it.
Then unmount, reboot, and you're all set!

```shell
sudo nixos-install --root /mnt --no-root-passwd --flake github:Jadarma/nixfiles#nixos
sudo nixos-enter --root /mnt -c 'passwd me'
sudo umount -R /mnt
sudo swapoff -L NIXOS_SWAP
sudo vgchange -a n lvmroot
sudo cryptsetup close /dev/mapper/cryptroot
reboot
```

After booting, you should also clone the repo so you can edit it locally as well.
