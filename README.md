# Kubernetes the Hard Way with Lima

## Overview
This project provides a setup to run [Kubernetes the Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way) in a Lima environment.

## Prerequisites
- [Homebrew](https://brew.sh/)
- [go-task](https://taskfile.dev/)
- [Lima](https://github.com/lima-vm/lima)

## Setup Instructions

### 1. Install go-task
Run the following command to install `go-task`:

```bash
brew install go-task
```

### 2. Clone the Repository
Run the `clone-repo` task defined in `Taskfile.yml` to clone the repository:

```bash
task clone-repo
```

This will clone the `kubernetes-the-hard-way` repository into the project directory. The purpose of cloning this repository is to allow tools like GitHub Copilot or other AI systems to reference its content for assistance during development. Note that the cloned repository is included in `.gitignore`, so it will not be tracked by this project's version control system.

## Notes
- Ensure that `go-task` is installed correctly.
- If there is existing data in the target directory, it may be overwritten.