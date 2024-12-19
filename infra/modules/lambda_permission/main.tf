# Permitir que cada alarma invoque la función Lambda
resource "aws_lambda_permission" "allow_cloudwatch_invocation" {
  statement_id     = "AllowCloudWatchToInvokeLambda"
  action           = "lambda:InvokeFunction"
  function_name    = var.lambda_function_name
  principal        = "cloudwatch.amazonaws.com"
}