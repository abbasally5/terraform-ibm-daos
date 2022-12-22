/**
 * Copyright 2022 Intel Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "region" {
  description = "IBM Cloud Region where resources will be deployed"
  type        = string
  default     = "us-south"
}

variable "zone" {
  description = "IBM Cloud Zone"
  type        = string
  default     = "us-south-3"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "Default"
}

variable "resource_prefix" {
  description = "String to prepend to all resource names"
  type        = string
  default     = null
}

variable "vpc_name" {
  description = "Name of VPC where DAOS instances will be deployed"
  type        = string
  default     = "daos"
}

variable "bastion_ssh_allowed_ips" {
  description = "Allowed CIDRs for ingress rules to the bastion Security Group"
  type = list(object({
    name = string
    cidr = string
  }))
  default = [
    {
      name = "ANY"
      cidr = "0.0.0.0/0"
    }
  ]
}

variable "bastion_public_key" {
  description = "Public key data in 'Authorized Keys' format to allow you to log into the bastion host as the daos_admin user."
  type        = string
}

variable "ssh_key_names" {
  description = "List of SSH key names to add to DAOS instances"
  type        = list(string)
  default     = []
}

#
# DAOS Server
#

variable "server_instance_count" {
  description = "Number of DAOS server instances to deploy"
  type        = number
  default     = 1
}

variable "server_instance_base_name" {
  description = "DAOS server instance base name"
  type        = string
  default     = "daos-server"
}

variable "server_use_bare_metal" {
  description = "Use bare metal for DAOS server instances"
  type        = bool
  default     = true
}


#
# DAOS Client
#

variable "client_instance_count" {
  description = "Number of DAOS client instances to deploy"
  type        = number
  default     = 1
}


#
# DAOS Admin
#

# TODO: Remove this override when
#       https://raw.githubusercontent.com/daos-stack/ansible-collection-daos/main/install_ansible.sh"
#       is available
variable "admin_ansible_install_script_url" {
  description = "URL for script that installs Ansible"
  type        = string
  default     = "https://raw.githubusercontent.com/daos-stack/ansible-collection-daos/develop/install_ansible.sh"
}

# TODO: Remove this override when
#       https://github.com/daos-stack/ansible-collection-daos.git,main
#       is available.
variable "admin_ansible_playbooks" {
  description = "Ansible information to be used in a template that generates a user_data script"
  type = list(object({
    venv_dir           = string
    collection_fqn     = string
    collection_git_url = string
    playbook_fqn       = string
  }))
  default = [
    {
      venv_dir           = "/root/daos-ansible/venv"
      collection_fqn     = "daos_stack.daos"
      collection_git_url = "git+https://github.com/daos-stack/ansible-collection-daos.git,develop"
      playbook_fqn       = "daos_stack.daos.daos_cluster"
    }
  ]
}
