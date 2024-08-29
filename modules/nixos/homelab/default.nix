{ ... }: {

  # Trust the self-signed CA for local homelab.
  security.pki.certificates = [
    (builtins.readFile ./homelabRootCA.crt)
  ];
}
