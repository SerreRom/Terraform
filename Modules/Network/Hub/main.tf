
#----------------------------------------#
# Resource Group Creation                #
#----------------------------------------#

resource "azurerm_resource_group" "rg" {
    name     = lower(var.resource_group_name)
    location = var.location
    tags     = merge({ "ResourceName" = format("%s", var.resource_group_name) }, var.tags, )
}

#----------------------------------------#
# Azure Virtual WAN                      #
#----------------------------------------#

resource "azurerm_virtual_wan" "vwan1" {
    name                = lower(var.vwan_name)
    resource_group_name = azurerm_resource_group.rg.name
    location            = var.location
    # Configuration 
    office365_local_breakout_category = "OptimizeAndAllow"
    tags     = merge({ "ResourceName" = format("%s", var.resource_group_name) }, var.tags, )
}

# Virtual WAN Hubs
#-----------------------------------------

resource "azurerm_virtual_hub" "vwan1-hub1" {
    name                      = lower("hub-${var.vwan_name}-01")
    resource_group_name       = azurerm_resource_group.rg.name
    location                  = var.location
    virtual_wan_id            = azurerm_virtual_wan.vwan1.id
    address_prefix            = var.vwan1-hub1-prefix
    internet_security_enabled = true
    tags = {
        tags     = merge({ "ResourceName" = format("%s", var.resource_group_name) }, var.tags, )
    }
}

resource "azurerm_firewall" "vwan1-fw01" {
    name                = lower("fw01-${var.vwan_name}")
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    sku_tier            = "Premium"
    sku_name            = "AZFW_Hub"
    firewall_policy_id  = azurerm_firewall_policy.fw-pol1.id
    virtual_hub {
        virtual_hub_id = azurerm_virtual_hub.vwan1-vhub1.id
        public_ip_count = 1
    }
}

#Firewall Policy
resource "azurerm_firewall_policy" "fw-pol1" {
    name                = lower("pol01-${var.vwan_name}")
    resource_group_name = azurerm_resource_group.rg.name
    location            = var.location
    }
    # Firewall Policy Rules
    resource "azurerm_firewall_policy_rule_collection_group" "region1-policy1" {
    name               = "fw-pol01-rules"
    firewall_policy_id = azurerm_firewall_policy.fw-pol01.id
    priority           = 100
    network_rule_collection {
        name     = "network_rules1"
        priority = 100
        action   = "Allow"
        rule {
        name                  = "network_rule_collection1_rule1"
        protocols             = ["TCP", "UDP", "ICMP"]
        source_addresses      = ["*"]
        destination_addresses = ["*"]
        destination_ports     = ["*"]
        }
    }
}