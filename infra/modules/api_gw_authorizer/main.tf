resource "aws_api_gateway_authorizer" "custom_auth" {
  name                             = var.name
  rest_api_id                      = var.rest_api_id
  type                             = var.type
  identity_source                  = var.identity_source
  authorizer_uri                   = var.authorizer_uri
  authorizer_credentials           = var.authorizer_credentials
  authorizer_result_ttl_in_seconds = var.authorizer_result_ttl_in_seconds
  identity_validation_expression   = var.identity_validation_expression
}