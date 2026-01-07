{ self, inputs, ... }:
{
  imports = [ inputs.easy-hosts.flakeModule ];

  easy-hosts = {
    perClass = class: {
      modules = [
        "${self}/modules/${class}/default.nix"
      ];
    };

    hosts = {
      chloe-tuxedo = { };
    };
  };
}
