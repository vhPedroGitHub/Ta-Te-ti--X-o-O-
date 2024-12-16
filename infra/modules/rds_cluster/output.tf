output "aws_rds_cluster_id" {
  value       = aws_rds_cluster.cluster_rds.id
  description = "aws rds cluster id"
}

output "aws_rds_cluster_endpoint" {
  value       = aws_rds_cluster.cluster_rds.endpoint
  description = "aws rds cluster instance"
}

output "aws_rds_cluster_reader_endpoint" {
  value       = aws_rds_cluster.cluster_rds.reader_endpoint
  description = "aws rds cluster instance"
}

output "aws_rds_cluster_identifier" {
  value       = aws_rds_cluster.cluster_rds.cluster_identifier
  description = "aws_rds_cluster_identifier"
}

output "aws_rds_cluster_port" {
  value       = aws_rds_cluster.cluster_rds.port
  description = "aws_rds_cluster_port"
}

output "aws_rds_cluster_database_name" {
  value       = aws_rds_cluster.cluster_rds.database_name
  description = "aws_rds_cluster_database_name"
}