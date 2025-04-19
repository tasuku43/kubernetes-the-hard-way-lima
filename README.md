# Kubernetes the Hard Way with Lima

## Overview
This project provides a setup to run [Kubernetes the Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way) in a Lima environment.

## Prerequisites
- [Homebrew](https://brew.sh/)
- [go-task](https://taskfile.dev/)
- [Lima](https://github.com/lima-vm/lima)

## Setup Instructions

### 1. Install Prerequisites
Install the required tools:

```bash
brew install go-task lima
```

### 2. Clone the Repository
Run the following command to clone the reference repository:

```bash
task clone-repo
```

### 3. Start the Instances
Run the following command to create and start all Lima instances:

```bash
task create-all
```

This will create and start the following Lima instances:
- `jumpbox`: The machine used to access the Kubernetes cluster
- `server`: The Kubernetes control plane node
- `node-0`: The first Kubernetes worker node
- `node-1`: The second Kubernetes worker node

## Notes
- Ensure all prerequisites are installed correctly
- You can validate the instances with `task validate-all`
- If you need to recreate the instances, use `task recreate-all`