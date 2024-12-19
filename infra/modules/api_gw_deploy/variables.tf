variable "rest_api_id" {
  description = "rest_api_id"
  type        = string
}
variable "stage_name" {
  description = "stage_name"
  type        = string
}
variable "deployed_at" {
  description = "deployed_at"
  type        = string
}
variable "xray_tracing_enabled" {
  description = "xray_tracing_enabled"
  type        = string
  default     = true
}