output "arn" {
  description = "ARN of the API Gateway Authorizer"
  value       = aws_api_gateway_authorizer.custom_auth.arn
}

output "id" {
  description = "Authorizer identifier"
  value       = aws_api_gateway_authorizer.custom_auth.id
}