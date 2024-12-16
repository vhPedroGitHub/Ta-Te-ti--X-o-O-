output "aws_rds_proxy_endpoint_writer" {
  value       = aws_db_proxy.rds_db_proxy.endpoint
  description = "aws_rds_proxy_endpoint"
}

output "aws_rds_proxy_endpoint_reader" {
  value       = aws_db_proxy_endpoint.this.endpoint
  description = "aws_rds_proxy_endpoint"
}