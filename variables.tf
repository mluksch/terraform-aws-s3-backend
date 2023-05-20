// Variables-Declaration-File
variable "namespace" {
  type = string
}

variable "user_arns" {
  type = list(string)
  default = []
}

variable "new_users" {
  type = list(string)
  default = []
}