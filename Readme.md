# OpenMLS Workspace

This repository holds a helpers to work with OpenMLS.

## Usage

### Repository handling

```
./openmls.sh help
Usage: ./openmls [setup] [pull] [switch] [clear] [branch]
                 setup        clone repositories for the first time
                 switch       switch branches according to config
                 pull         pull all repositories
                 clear        delete all local repositories
                 branch       list branches for all repositories
```

### Branches

`config` holds the branch names to use.

### Config.toml

The `Config.toml` defines a common workspace for all repositories.
This allows to develop across different repositories and crates at the same time.
