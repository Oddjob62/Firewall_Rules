locals {
  network_rule_collections_2 = [
    {
      name     = "Basic-RuleCollection2"
      priority = 1100
      action   = "Allow"
      rules = [
        {
          name                  = "Ping"
          protocols             = ["ICMP"]
          source_addresses      = []
          source_ip_groups      = [azurerm_ip_group.MainUSVnetIPSpace.id]
          destination_addresses = []
          destination_ip_groups = [azurerm_ip_group.MainUSVnetIPSpace.id]
          destination_fqdns     = []
          destination_ports     = ["*"]
        },
        {
          name                  = "RDP"
          protocols             = ["TCP"]
          source_addresses      = []
          source_ip_groups      = [azurerm_ip_group.MainUSVnetIPSpace.id]
          destination_addresses = []
          destination_ip_groups = []
          destination_fqdns     = ["test.home.com"]
          destination_ports     = ["3389"]
        }
      ]
    }
  ]
}
