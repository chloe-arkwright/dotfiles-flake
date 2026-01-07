{
  inputs,
  ...
}:
{
  imports = [
    ../hosts
  ];

  perSystem =
    { pkgs, system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };
    };
}
