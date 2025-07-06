variable "do_token" {
    description = "Digital Ocean Carlos Token"
    sensitive = true
    default = "Digital Ocean TK"
}

variable "public_key" {
  type        = string
  description = "The existing key on Digital Ocean"
  sensitive = true
  default     = "clave"
}