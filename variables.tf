// Variables-Declaration-File
variable "namespace" {
  type = string
}

variable "existing_users" {
  description = "ARNs of existing users"
  type = list(string)
  default = []
}

variable "new_users" {
  description = "Names of new users for who a new iam user gets created with access keys"
  type = list(string)
  default = []
}