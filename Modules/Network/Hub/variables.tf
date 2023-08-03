variable "resource_group_name" {
    description = "A container that holds related resources for an Azure solution"
    default     = "rg-hub-shared-001"
}
variable "location" {
    description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
    default     = "francecentral"
}
variable "vwan_name" {
    description = "Name of the Azure Virtual WAN"
    default     = "vwan-shared-francecentral-001"
}
variable "tags" {
    description = "A map of tags to add to all resources"
    type        = map(string)
    default     = {}
}

variable "vwan-region1-hub1-prefix" {
    description = "IP address space for the hub network in Azure Virtual WAN"
    default        = "10.11.0.0/24"
}