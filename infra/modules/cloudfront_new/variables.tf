#origin
variable "domain_name" {
  description = "DNS domain name of either the S3 bucket, or web site of your custom origin"
  type = string
}
variable "origin_path" {
  description = "Optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin"
  type = string
  default = null
}
variable origin_access_control_origin_type {
  description = "The type of origin that this Origin Access Control is for. Valid values are lambda, mediapackagev2, mediastore, and s3"
  type = string  
  default = "disabled"
}
variable cloudfront_origin_access_control_name {
  description = "Optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin"
  type = string
  default = "disabled"
}
variable cloudfront_origin_access_control_description {
  description = "The description of the Origin Access Control. Defaults to Managed by Terraform if omitted"
  type = string
  default = null
}
# variable origin_protocol_policy {
#   description = "Origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer"
#   type = string
#   default = "https-only"  
# }
# variable origin_ssl_protocols {
#   description = " List of SSL/TLS protocols that CloudFront can use when connecting to your origin over HTTPS. Valid values: SSLv3, TLSv1, TLSv1.1, TLSv1.2. For more information, see Minimum Origin SSL Protocol in the Amazon CloudFront Developer Guide"
#   type = list(string)
#   default = ["TLSv1.2"]
# }
variable "custom_origin_config" {
 description = "The CloudFront custom origin configuration information. If an S3 origin is required, use origin_access_control_id or s3_origin_config instead"
 type = list(object({
    http_port              = number
    https_port             = number
    origin_protocol_policy = string
    origin_ssl_protocols   = list(string)
 }))
 default = [
    {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  ]
}
variable "custom_header" {
 description = "One or more sub-resources with name and value parameters that specify header data that will be sent to the origin (multiples allowed)"
 type = list(object({
    name  = string
    value = string
 }))
 default = []
}
#default_cache_behavior
variable "allowed_methods" {
  description = "Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin"
  type = list(string)
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}
variable "cached_methods" {
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods"
  type = list(string)
  default     = ["GET", "HEAD"]
}
variable viewer_protocol_policy {
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https"
  type = string
  default = "redirect-to-https"  
}
variable origin_request_policy_id {
  description = "Unique identifier of the origin request policy that is attached to the behavior"
  type = string
  default = null  
}
variable compress {
  description = "Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false)"
  type = bool
  default = true  
}
variable smooth_streaming {
  description = "Indicates whether you want to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior"
  type = bool
  default = false  
}
variable min_ttl {
  description = "Minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds"
  type = number
  default = 0  
}
variable default_ttl {
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header"
  type = number
  default = 0  
}
variable max_ttl {
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers"
  type = number
  default = 0  
}
variable cache_policy_id {
  description = "Unique identifier of the cache policy that is attached to the cache behavior. If configuring the default_cache_behavior either cache_policy_id or forwarded_values must be set"
  type = string
}



variable "enabled" {
  description = "Whether the distribution is enabled to accept end user requests for content"
  type = bool
  default     = true
}
variable "is_ipv6_enabled" {
  description = "Whether the IPv6 is enabled for the distribution"
  type = bool
  default     = true
}
variable "comment" {
  description = "Any comments you want to include about the distribution"
  type = string
  default     = ""
}
variable "default_root_object" {
  description = "Object that you want CloudFront to return (for example, index.html) when an end user requests the root URL"
  type = string
  default     = null
}
variable "aliases" {
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution"
  type = list(string)
  default     = null
}
variable "web_acl_id" {
  description = "Unique identifier that specifies the AWS WAF web ACL, if any, to associate with this distribution. To specify a web ACL created using the latest version of AWS WAF (WAFv2), use the ACL ARN, for example aws_wafv2_web_acl.example.arn. To specify a web ACL created using AWS WAF Classic, use the ACL ID, for example aws_waf_web_acl.example.id. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned."
  type        = string
  default     = null
}
variable "http_version" {
  description = "Maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3 and http3. The default is http2"
  type = string
  default     = "http2"
}
variable "tags" {
  description = "A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level"
  type        = map(string)
  default     = {}
}
variable "price_class" {
  description = "Price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  type        = string
  default     = null
}
#viewer_certificate
variable "cloudfront_default_certificate" {
  description = "true if you want viewers to use HTTPS to request your objects and you're using the CloudFront domain name for your distribution. Specify this, acm_certificate_arn, or iam_certificate_id"
  type        = bool
  default     = true
}
variable "acm_certificate_arn" {
  description = "ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. Specify this, cloudfront_default_certificate, or iam_certificate_id. The ACM certificate must be in US-EAST-1"
  type        = string
  default     = null
}
variable "minimum_protocol_version" {
  description = "Minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. Can only be set if cloudfront_default_certificate = false. See all possible values in this table under Security policy Some examples include: TLSv1.2_2019 and TLSv1.2_2021. Default: TLSv1. NOTE: If you are using a custom certificate (specified with acm_certificate_arn or iam_certificate_id), and have specified sni-only in ssl_support_method, TLSv1 or later must be specified. If you have specified vip in ssl_support_method, only SSLv3 or TLSv1 can be specified. If you have specified cloudfront_default_certificate, TLSv1 must be specified"
  type        = string
  default     = "TLSv1.2_2021"
}
variable "ssl_support_method" {
  description = "How you want CloudFront to serve HTTPS requests. One of vip, sni-only, or static-ip. Required if you specify acm_certificate_arn or iam_certificate_id. NOTE: vip causes CloudFront to use a dedicated IP address and may incur extra charges"
  type        = string
  default     = "sni-only"
}
#restrictions
variable "restriction_type" {
  description = " Method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist"
  type        = string
  default     = "none"
}
variable "locations" {
  description = "ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist). If the type is specified as none an empty array can be used"
  type        = list(string)
  default     = []
}

variable logging_config {
  description = "The logging configuration that controls how logs are written to your distribution (maximum one)"
  type = list(object({
     include_cookies = bool 
     bucket          = string 
     prefix          = string 
  }))
  default = []
}