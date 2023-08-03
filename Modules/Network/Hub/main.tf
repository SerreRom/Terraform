
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
    name                = lower("${var.vwan_name}-vWAN-hub-01")
    resource_group_name = azurerm_resource_group.region1-rg.name
    location            = var.location
    virtual_wan_id      = azurerm_virtual_wan.vwan1.id
    address_prefix      = var.vwan1-hub1-prefix
    tags = {
        Environment = var.environment_tag
    }
}