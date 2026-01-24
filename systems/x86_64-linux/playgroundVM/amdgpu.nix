# AMDGPU
# Configures the system for my 7900XTX.
{ nixos-hardware, ... }:
{
  imports = [
    nixos-hardware.nixosModules.common-gpu-amd
  ];

  # Kernel
  boot = {
    initrd = {
      availableKernelModules = [ "amdgpu" ];
      kernelModules = [ "amdgpu" ];
    };
    kernelModules = [ "kvm-amd" ];
    extraModprobeConfig = ''
      options amdgpu gpu_recovery=1
      options amdgpu lbpw=1
      options amdgpu dpm=1
    '';
  };

  # Force the use of RADV driver for Vulkan.
  environment.variables.AMD_VULKAN_ICD = "RADV";

  # Driver configuration GUI.
  services.lact.enable = true;
  hardware.amdgpu.overdrive.enable = true;
}
