import tseslint from "typescript-eslint";
import eslint from "@eslint/js";
import globals from "globals";

export default tseslint.config(
    {
        ignores: ["**/dist/*", "**/build/*", "node_modules"],
    },
    eslint.configs.recommended,
    tseslint.configs.strict,
    tseslint.configs.stylistic,
    {
        files: ["**/*.{ts,tsx,js,jsx,cjs,mjs}"],
        languageOptions: {
            ecmaVersion: 2020,
            globals: globals.node,
            parserOptions: {
                tsconfigRootDir: import.meta.dirname,
                projectService: true,
            },
        },
        rules: {
            "@typescript-eslint/consistent-type-definitions": "off",
            "@typescript-eslint/consistent-type-imports": [
                "warn",
                {
                    prefer: "type-imports",
                    fixStyle: "separate-type-imports",
                },
            ],
            "@typescript-eslint/no-unused-vars": [
                "warn",
                {
                    argsIgnorePattern: "^_",
                    varsIgnorePattern: "^_",
                    caughtErrorsIgnorePattern: "^_",
                },
            ],
            "@typescript-eslint/require-await": "error",
            "@typescript-eslint/no-misused-promises": [
                "error",
                {
                    checksVoidReturn: false,
                },
            ],
        },
    },
);
