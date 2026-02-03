{
  flake.modules.nixos.usersGeneric = {
    users.mutableUsers = true;
    users.defaultUserHome = "/home";
  };
}
