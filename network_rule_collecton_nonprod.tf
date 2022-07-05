locals {
  NonProd_RuleCollection = [
    {
      name     = "NonProd-RuleCollection"
      priority = 1200
      action   = "Allow"
      rules = [
        {
          name                  = "Unencrypted_Web"
          protocols             = ["TCP"]
          source_addresses      = ["*"]
          source_ip_groups      = []
          destination_addresses = ["*"]
          destination_ip_groups = []
          destination_fqdns     = []
          destination_ports     = ["80"]
        }
      ]
    }
  ]
}
