output "domain_name" {
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net"
  value       = aws_cloudfront_distribution.aws_cloudfront_distribution.domain_name
}

output "hosted_zone_id" {
  description = "CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID Z2FDTNDATAQYW2"
  value       = aws_cloudfront_distribution.aws_cloudfront_distribution.hosted_zone_id
}

output "arn" {
  description = " ARN for the distribution. For example: arn:aws:cloudfront::123456789012:distribution/EDFDVBD632BHDS5, where 123456789012 is your AWS account ID"
  value       = aws_cloudfront_distribution.aws_cloudfront_distribution.arn
}

output "id" {
  description = "Identifier for the distribution. For example: EDFDVBD632BHDS5"
  value       = aws_cloudfront_distribution.aws_cloudfront_distribution.id
}