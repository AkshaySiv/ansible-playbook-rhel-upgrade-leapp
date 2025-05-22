# rhel8-psim-automation
Ansible automation for upgrading RHEL 8 using Leapp in a Power Simulator environment. This repository contains playbooks and scripts to streamline the upgrade process, manage network configurations, and ensure smooth system transitions in IBM Power systems.

# Ansible Setup Overview

Ansible is an open-source automation tool used for configuration management, application deployment, task automation, and multi-node orchestration. In an Ansible setup, different roles help organize tasks and provide a clear structure for managing configurations across multiple servers.

## Roles Overview

### Preupgrade Role

- **Purpose:** This role prepares the servers for an upgrade by ensuring the environment is set up correctly and any necessary prerequisites are in place.
- **Key Tasks:**
  - Create a YUM repository file to manage package installations.
  - Check if the `leapp` tool is installed on the server.
  - Modify the SSH configuration to allow root login by uncommenting `PermitRootLogin`.
  - Restart the SSHD service if the SSH configuration is changed.
  - Run the `leapp preupgrade` command to prepare for the upgrade, ensuring the necessary repositories are enabled.
  - Check the result of the `leapp preupgrade` to ensure it completed successfully.
  - Extract a summary from the Leapp report to assess any risk factors.
  - Display the Leapp report summary for review and confirmation.

### Upgrade Role

- **Purpose:** This role executes the leapp upgrade process and reboot.
- **Key Tasks:**
  - Start the Leapp upgrade with necessary options (e.g., disabling RHSM and enabling required repositories).
  - Change network interface names as needed.
  - Trigger a system reboot after the upgrade.

### Postupgrade Role

- **Purpose:** This role handles tasks that need to be executed after the upgrade process, ensuring that the system operates correctly and that services are configured as intended.
- **Key Tasks:**
  - Create symbolic links for required versions of software (e.g., Python).
  - Install essential packages and dependencies using `pip2`.
  - Adjust Magneto Modifications to Ensure RHEL8 Support
  - Validate service statuses by checking if services are active and functioning correctly.


## Running Playbook

### Prerequisites
- Use a fire machine to run the playbook and enable passwordless authentication to the target machines
- Ensure you have Ansible installed on your fire machine.
- Install leapp on target machines
- Mount RHEL 8 iso in fire vm and update url in - leapp_upgrade_playbook/group_vars/all.yml

### Steps to Execute the Roles

1. **Clone the Repository:**
Use any fire machine to clone this repository containing the Leapp upgrade playbook

2. **Navigate to the Playbook Directory:**
Change your directory to the leapp_upgrade_playbook/ folder where the playbook is located `cd leapp_upgrade_playbook/`

3. **Ensure target host are updated:**
All target machines should be added in hosts file under leapp_upgrade_playbook/ 

4. **Execute the role in below order:**
Run the following commands in the specified order to execute the playbooks successfully

`ansible-playbook playbook.yml --tags "preupgrade"`

`ansible-playbook playbook.yml --tags "upgrade"`

`ansible-playbook playbook.yml --tags "postupgrade"`
