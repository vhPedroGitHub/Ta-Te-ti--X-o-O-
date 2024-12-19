resource "aws_api_gateway_deployment" "deployment" {
  depends_on  = [time_sleep.wait_x_seconds]
  rest_api_id = var.rest_api_id
  lifecycle {
    create_before_destroy = true
  }
  # triggers = {
  #    redeployment = sha1(
  #      join(",", [
  #        for file in fileset("${path.cwd}", "api_*.tf") : file("${path.cwd}/${file}")
  #      ])
  #    )
  # }
  variables = {
    deployed_at = "${var.deployed_at}"
  }
}

resource "time_sleep" "wait_x_seconds" {
 create_duration = "60s"
  # triggers = {
  #    redeployment = sha1(
  #      join(",", [
  #        for file in fileset("${path.cwd}", "api_*.tf") : file("${path.cwd}/${file}")
  #      ])
  #    )
  # }
  triggers = {
    redeployment = sha1(jsonencode(var.deployed_at))
  }
}

resource "aws_api_gateway_stage" "stage" {
  # depends_on = [aws_cloudwatch_log_group.this]
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = var.rest_api_id
  stage_name  = var.stage_name
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.this.arn
    format         = "$context.identity.sourceIp $context.httpMethod $context.path $context.status $context.requestId"
  }
  xray_tracing_enabled  = var.xray_tracing_enabled
  # cache_cluster_enabled =
  # cache_cluster_size    = 
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "API-Gateway-Execution-Logs_${var.rest_api_id}/${var.stage_name}"
  retention_in_days = 7
}

resource "aws_api_gateway_method_settings" "this" {
  rest_api_id = var.rest_api_id
  stage_name  = aws_api_gateway_stage.stage.stage_name
  method_path = "*/*"

  settings {
    logging_level      = "INFO"
    metrics_enabled    = true
    data_trace_enabled = true
    # caching_enabled = true
    # cache_data_encrypted = true
  }
}