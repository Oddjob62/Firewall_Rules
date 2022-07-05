terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

variable "config_name" {
  type        = string
  description = "The name of the configuration file to use"
  default     = "test"
}

locals {
  collectioname = "Basic-RuleCollection"
  config_content  = file("./${var.config_name}.yaml")
  config         = yamldecode(local.config_content)
  default_tags   = {}
}

# output testoutput {
#     value = local.config.network_rule_collections
# }

# module ipgroupsmodule {
#         source = "./modules/ipgrouplist"
#         ipgroups = ["MainUSVnetIPSpace","HomeBase"]
# }

# output testdata {
#     value = module.ipgroupsmodule.ipgroups
# }