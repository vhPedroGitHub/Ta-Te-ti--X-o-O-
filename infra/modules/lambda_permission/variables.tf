# variable "statement_id" {
#   description = "statement_id"
#   type        = string
#   default     = "AllowExecutionFromAPIGateway"
# }
# variable "action" {
#   description = "action"
#   type        = string
#   default     = "lambda:InvokeFunction"
# }
# variable "integration_lambda_function_name" {
#   description = "integration_lambda_function_name"
#   type        = string
# }
# variable "principal" {
#   description = "principal"
#   type        = string
#   default     = "apigateway.amazonaws.com"
# }
# variable "source_arn" {
#   description = "source_arn"
#   type        = string
# }

# variable "source_account" {
#   description = " This parameter is used when allowing cross-account access, or for S3 and SES. The AWS account ID (without a hyphen) of the source owner."
#   type        = string
#   default     = null
# }

# variable "alarm_arn" {
#   type = string
# }
variable "lambda_function_name" {
  type = string
}