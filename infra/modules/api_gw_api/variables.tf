variable "api_gw_name" {
  description = "api_gw_name"
  type        = string
}
variable "api_gw_description" {
  description = "api_gw_description"
  type        = string
  default     = ""
}

variable access_control_allow_origin {
  description = ""
  type = string
  default = "'*'"
}
variable access_control_allow_headers {
  description = ""
  type = string
  default = "'*'"
}
variable access_control_allow_methods {
  description = ""
  type = string
  default = "'*'"
}