data "aws_region" "current" {}

resource "aws_db_proxy" "rds_db_proxy" {
  name                   = var.name
  engine_family          = var.engine_family
  idle_client_timeout    = var.idle_client_timeout
  require_tls            = var.require_tls
  role_arn               = aws_iam_role.this.arn
  vpc_security_group_ids = var.vpc_security_group_ids
  vpc_subnet_ids         = var.vpc_subnet_ids

  auth {
    auth_scheme = "SECRETS"
    iam_auth = "DISABLED"
    secret_arn = var.secret_arn
  }
  tags = var.tags
}

resource "aws_db_proxy_default_target_group" "rds_db_proxy_target_group" {
  db_proxy_name = aws_db_proxy.rds_db_proxy.name

  connection_pool_config {
    connection_borrow_timeout = var.connection_borrow_timeout
    max_connections_percent = var.max_connections_percent
  }
}

resource "aws_db_proxy_target" "db_proxy_target" {
  db_cluster_identifier = var.db_cluster_identifier
  db_proxy_name = aws_db_proxy.rds_db_proxy.name
  target_group_name = aws_db_proxy_default_target_group.rds_db_proxy_target_group.name
}

resource "aws_db_proxy_endpoint" "this" {
  db_proxy_name          = aws_db_proxy.rds_db_proxy.name
  db_proxy_endpoint_name = var.db_proxy_endpoint_name
  vpc_subnet_ids         = var.vpc_subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids
  target_role            = "READ_ONLY"
}

resource "aws_iam_role" "this" {
  name = "${var.name}-rds-proxy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "rds.amazonaws.com"
        }
      },
    ]
  })


  inline_policy {
    name = "${var.name}-rds-proxy-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["secretsmanager:GetSecretValue"]
          Effect   = "Allow"
          Resource = "*"
        },
        {
          Action   = ["kms:Decrypt"]
          Effect   = "Allow"
          Resource = "*"
          Condition = {
            StringEquals = {
              "kms:ViaService" = "secretsmanager.${data.aws_region.current.name}.amazonaws.com"
            }
          }
        },
      ]
    })
  }
}