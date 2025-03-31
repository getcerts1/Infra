variable "location" {
  type    = string
  default = "westus"
}

variable "rg-name" {
  type    = string
  default = "infra-rg-001"
}

variable "subscription_id" {
  type = string
  sensitive = true
}

variable "tenant_id" {
  type = string
  sensitive = true
}

variable "client_id" {
  type = string
  sensitive = true
}

variable "client_secret" {
  type = string
  sensitive = true
}