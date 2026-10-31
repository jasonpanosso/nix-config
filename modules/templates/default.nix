{
  flake.templates = {
    rust = {
      path = ./_rust;
      description = "Basic rust template";
    };

    typescript = {
      path = ./_typescript;
      description = "Typescript template with prettier & eslint";
    };

    go = {
      path = ./_go;
      description = "Basic golang template";
    };
  };
}
