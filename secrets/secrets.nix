let
  mo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMjOnvUtNa2LtSA+ch0cjyRFRO/xP6k+xp15IGWu9fdw";
  keys = [ mo ];
in
{
  # generate these using `agenix -e $SECRET_NAME.age`
  "google-drive-client-id.age".publicKeys = keys;
  "google-drive-client-secret.age".publicKeys = keys;
  "google-drive-token.age".publicKeys = keys;
}
