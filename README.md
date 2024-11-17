# config.nvim

<a href="https://dotfyle.com/noirbizarre/confignvim"><img src="https://dotfyle.com/noirbizarre/confignvim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/noirbizarre/confignvim"><img src="https://dotfyle.com/noirbizarre/confignvim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/noirbizarre/confignvim"><img src="https://dotfyle.com/noirbizarre/confignvim/badges/plugin-manager?style=flat" /></a>

My personal NeoViM configuration

## Layout

```shell
├── init.lua          # Configuration entrypoint
├── lazy-lock.json    # Lazy lock file
├── lua
│   ├── setup         # Early executable modules, configure by calling or setting
│   ├── lib           # Exportable modules, reusable snippets
│   └── plugins       # Lazy plugins specs
└── static            # Some static files
```

Some configuration parts have been extracted into their own modules for easier editing as well as more concise plugin specs.
