{ inputs, ... }:

{
  flake.overlays.rust-overlay = inputs.rust-overlay.overlays.default;
}
