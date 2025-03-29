variable "rg-name" {
  type    = string
}


variable "location" {
  type    = string
  default = "westus"
}

variable "hub-vnet-name" {
  type    = string
  default = "hub-vnet-001"

}

variable "spoke-vnet-name" {
  type    = string
  default = "spoke-vnet-001"
}

variable "hub-subnet-001" {
  type    = string
  default = "ApplicationGatewaySubnet"
}

variable "spoke-subnet-001" {
  type    = string
  default = "funcapp-subnet"

}

variable "spoke-subnet-002" {
  type    = string
  default = "PrivateEndpointSubnet-001"
}





