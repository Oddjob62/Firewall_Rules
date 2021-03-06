locals {
  non_prod_extra_collections = local.config.environment == "np" ? local.NonProd_RuleCollection : []
  network_rule_collections = concat(local.network_rule_collections_1, local.network_rule_collections_2, local.non_prod_extra_collections)
}

resource "azurerm_firewall_policy" "example" {
  name                = "example-policy"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  dns {
    proxy_enabled = true
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "example" {
  name               = "example-fwpolicy-rcg"
  firewall_policy_id = azurerm_firewall_policy.example.id
  priority           = 500

  dynamic "network_rule_collection" {
    for_each = local.network_rule_collections
    content {
      name     = network_rule_collection.value.name
      priority = network_rule_collection.value.priority
      action   = network_rule_collection.value.action
      dynamic "rule" {
        for_each = network_rule_collection.value.rules
        content {
          name                  = rule.value.name
          protocols             = rule.value.protocols[*]
          source_addresses      = rule.value.source_addresses[*] != null ? rule.value.source_addresses[*] : []
          source_ip_groups      = rule.value.source_ip_groups[*] != null ? rule.value.source_ip_groups[*] : []
          destination_addresses = rule.value.destination_addresses[*] != null ? rule.value.destination_addresses[*] : []
          destination_ip_groups = rule.value.destination_ip_groups[*] != null ? rule.value.destination_ip_groups[*] : []
          destination_fqdns     = rule.value.destination_fqdns[*] != null ? rule.value.destination_fqdns[*] : []
          destination_ports     = rule.value.destination_ports[*]
        }
      }
    }
  }
}

#   dynamic "network_rule_collection" {
#      for_each = local.config.network_rule_collections
#      content {
#       name     = network_rule_collection.key
#       priority = network_rule_collection.value.priority
#       action   = network_rule_collection.value.action
#       # rule {
#       #     name                  = "rulename"
#       #     protocols             = ["TCP", "UDP"]
#       #     source_ip_groups      = [azurerm_ip_group.MainUSVnetIPSpace.id]
#       #     destination_ip_groups = [azurerm_ip_group.MainUSVnetIPSpace.id]
#       #     destination_fqdns     = ["test.home.com"]
#       #     destination_ports     = ["*"]
#       # }
#       dynamic "rule" {
#         for_each = network_rule_collection.value.rules
#         content {
#           name                  = rule.key
#           protocols             = rule.value.protocols[*]
#           source_addresses      = rule.value.source_addresses[*] != null ? rule.value.source_addresses[*] : []
#           source_ip_groups      = rule.value.source_ip_groups[*] != null ? rule.value.source_ip_groups[*] : []
#           destination_addresses = rule.value.destination_addresses[*] != null ? rule.value.destination_addresses[*] : []
#           destination_ip_groups = rule.value.destination_ip_groups[*] != null ? rule.value.destination_ip_groups[*] : []
#           destination_fqdns     = rule.value.destination_fqdns[*] != null ? rule.value.destination_fqdns[*] : []
#           destination_ports     = rule.value.destination_ports[*]
#         }
#       }
#     }
#   }
# }
