# Kubernetes the Hard Way with Lima

## Overview

This project is a step-by-step implementation of [Kubernetes the Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way) using [Lima](https://github.com/lima-vm/lima), a lightweight virtual machine manager for macOS. It automates the process of setting up a Kubernetes cluster from scratch, providing a learning experience for understanding the inner workings of Kubernetes.

By using Lima, all virtual machines required for the Kubernetes cluster can run locally on a single macOS machine, eliminating the need to provision cloud infrastructure or dedicated hardware. This significantly lowers the barrier to entry and reduces cost, allowing anyone with a Mac to practice Kubernetes the Hard Way in a fully self-contained, reproducible environment.

## Prerequisites

### Installation

Before starting, ensure the following tools are installed:

- [Homebrew](https://brew.sh/): A package manager for macOS, used to install and manage software.
- [go-task](https://taskfile.dev/): A task runner for automating commands and scripts.
- [Lima](https://github.com/lima-vm/lima): A lightweight virtual machine manager for macOS, used to create and manage virtual machines.

Install them using:

```bash
brew install go-task lima
```

### Setup Init

#### 1. Create .env File

Create a `.env` file to store environment variables required for the setup process. 

environment variables are configured:

- `ROOT_DIR`: The absolute path to the root directory of this project.
- `ROOT_PASS`: A randomly generated password for SSH connections to the jumpbox and servers.

```bash
task 00:create-dotenv
```

#### 2. Install socket_vmnet

Install `socket_vmnet`, a lightweight virtual network framework for macOS. This framework enables Lima to create and manage virtual machine networks by leveraging the macOS `vmnet` framework. During installation, the necessary components are set up, and permissions are configured to allow Lima to establish bridged or shared networking for virtual machines. This step is crucial for ensuring proper network connectivity for the Kubernetes cluster.

```bash
task 00:install-socket-vmnet
```

#### 3. Download Docs

Download the documentation from [Kubernetes the Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way) into the `tasks` directory. Each subdirectory in `tasks` corresponds to a step in the Kubernetes setup process and includes a `Taskfile.yml` to automate the respective step. This task ensures that the necessary reference materials are available for each step.

```bash
task 00:download-docs
```

## Project Structure
The project is organized as follows:

- **Taskfile.yml**: Main task file orchestrating the setup, testing, and cleanup.
- **tasks/**: Directory containing subdirectories for each step of the Kubernetes setup. Each subdirectory corresponds to a specific step in the [Kubernetes the Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way) documentation, providing automation scripts and configurations for that step.

## Usage

### Basic Operations

#### 1. Starting the Cluster
To set up and start the Kubernetes cluster, run the following task:

```bash
task up-cluster
```
This command will execute all necessary steps to initialize the cluster, including setting up the jumpbox, configuring nodes, and provisioning the control plane and worker nodes.

#### 2. Testing the Cluster
To verify that the Kubernetes cluster is functioning correctly, perform a smoke test:

```bash
task smoke-test
```
This will run a series of tests to ensure the cluster is operational and ready for use.

#### 3. Cleaning Up the Cluster
To clean up the environment and remove the Kubernetes cluster, use the following command:

```bash
task clean-cluster
```
This will delete all resources and reset the environment to its initial state.


### Step-by-Step Execution

If you prefer to manually execute each step of the process, you can do so by running individual tasks. To see the list of available tasks, use the following command:

```bash
task --list
```
This will display all the tasks defined in the project, allowing you to execute them step-by-step for a more granular understanding of the setup process.

### Accessing Virtual Machines

To access the virtual machines created by Lima, you can use the following task:

```bash
task ssh-vm
```
This task provides an interactive menu to select the VM you want to connect to. If `fzf` or `gum` is installed on your system, the task will use one of these tools to provide a more user-friendly selection interface. Otherwise, it will fall back to a simple numbered menu. For example:

```bash
$ task ssh-vm
1) jumpbox
2) server
3) node-0
4) node-1
Select a VM to connect: 4
root@node-1:~#
```

Simply choose the desired VM from the list, and you will be connected via SSH. This is the recommended method for accessing virtual machines in this project.

## Contributing
Contributions are welcome! Please submit a pull request or open an issue for any suggestions or improvements.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.