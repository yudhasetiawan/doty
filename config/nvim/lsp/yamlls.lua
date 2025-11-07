return {
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require("schemastore").yaml.schemas({
        extra = {
          -- Currently, kubernetes is special-cased in yammls, see the following upstream issues:
          -- * [#211](https://github.com/redhat-developer/yaml-language-server/issues/211).
          -- * [#307](https://github.com/redhat-developer/yaml-language-server/issues/307).
          {
            description = "My custom JSON schema",
            fileMatch = "*.k8s.yaml",
            name = "kubernetes.json",
            url =
            "https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json",
          },
        },
      }),
    },
  },
}