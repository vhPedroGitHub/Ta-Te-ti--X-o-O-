variable "rest_api_id" {
  description = "rest_api_id"
  type        = string
}
variable "resource_id" {
  description = "resource"
  type        = string
}
variable "http_method" {
  description = "http_method"
  type        = string
  default     = ""
}
variable "authorization" {
  description = "authorization"
  type        = string
  default     = "NONE"
}
variable "authorizer_id" {
  description = "authorizer_id"
  type        = string
  default     = null
}
variable "integration_type" {
  description = "integration_type"
  type        = string
  default     = "AWS_PROXY"
}
variable "integration_lambda_invoke_arn" {
  description = "integration_uri"
  type        = string
  default     = ""
}
variable "integration_http_method" {
  description = "integration_http_method"
  type        = string
  default     = "POST"
}