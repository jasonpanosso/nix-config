{
  flake.templates = {
    rust = {
      path = ../../templates/rust;
      description = "Basic rust template";
    };

    typescript = {
      path = ../../templates/typescript;
      description = "Typescript template with prettier & eslint";
    };

    go = {
      path = ../../templates/go;
      description = "Basic golang template";
    };
  };
}
