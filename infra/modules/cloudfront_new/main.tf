resource "aws_cloudfront_origin_access_control" "this" {
  count                             = var.origin_access_control_origin_type == "s3" ? 1 : 0
  name                              = var.cloudfront_origin_access_control_name
  description                       = var.cloudfront_origin_access_control_description
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "aws_cloudfront_distribution" {
  origin {
    domain_name = var.domain_name
    origin_id   = var.domain_name
    origin_path = var.origin_path
    dynamic "custom_origin_config" {
      for_each = length(var.custom_origin_config) > 0 ? var.custom_origin_config : []
      content {
        http_port              = custom_origin_config.value.http_port
        https_port             = custom_origin_config.value.https_port
        origin_protocol_policy = custom_origin_config.value.origin_protocol_policy
        origin_ssl_protocols   = custom_origin_config.value.origin_ssl_protocols        
      }
    }
    origin_access_control_id = var.origin_access_control_origin_type == "s3" ? aws_cloudfront_origin_access_control.this[0].id : null

    dynamic "custom_header" {
      for_each = length(var.custom_header) > 0 ? var.custom_header : []
      content {
        name  = custom_header.value.name
        value = custom_header.value.value
      }
  }
}

  enabled         = var.enabled
  is_ipv6_enabled = var.is_ipv6_enabled
  comment         = var.comment
  default_root_object = var.default_root_object

  dynamic "logging_config" {
    for_each = length(var.logging_config) > 0 ? var.logging_config : []
    content {
      include_cookies = logging_config.value.include_cookies
      bucket          = logging_config.value.bucket
      prefix          = logging_config.value.prefix
    }
  }
  aliases = var.aliases

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = var.domain_name
    # response_headers_policy_id = aws_cloudfront_response_headers_policy.headers.id
    cache_policy_id  = var.cache_policy_id
    # forwarded_values {
    #   query_string = false

    #   cookies {
    #     forward = "none"
    #   }
    # }
    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl 
    max_ttl                = var.max_ttl 
    origin_request_policy_id = var.origin_request_policy_id
    compress = var.compress
    smooth_streaming  = var.smooth_streaming 
  }

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      locations        = var.locations
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = var.acm_certificate_arn == null ? var.cloudfront_default_certificate : false
    acm_certificate_arn = var.acm_certificate_arn
    minimum_protocol_version = var.acm_certificate_arn == null ? null : var.minimum_protocol_version
    ssl_support_method = var.ssl_support_method
  }
  
  price_class = var.price_class
  tags = var.tags
  http_version = var.http_version
  web_acl_id = var.web_acl_id

}



# resource "aws_cloudfront_response_headers_policy" "headers" {
#   name = "headers-policy-web"

#   security_headers_config {
#     content_type_options {
#       override = true
#     }
#     frame_options {
#       frame_option = "DENY"
#       override = true
#     }
#     referrer_policy {
#       referrer_policy = "same-origin"
#       override = true
#     }
#     xss_protection {
#       mode_block = true
#       protection = true
#       override = true
#     }
#     strict_transport_security {
#       access_control_max_age_sec = "63072000"
#       include_subdomains = true
#       preload = true
#       override = true
#     }
#     # content_security_policy {
#     #   content_security_policy = "frame-ancestors 'none'; default-src 'self' https://${var.web_domain_name} https://${var.api_domain_name} https://firebaseinstallations.googleapis.com https://fcmregistration.googleapis.com; img-src 'self' data: blob: https://${var.api_domain_name}; script-src 'self' https://${var.web_domain_name}/ 'unsafe-eval' https://www.gstatic.com/; style-src 'unsafe-inline' https://${var.web_domain_name}/; object-src 'none'; font-src 'self' data: https://${var.web_domain_name}/; connect-src 'unsafe-inline' https: https://fcmregistrations.googleapis.com/ https://${var.api_domain_name};"
#     #   override = true
#     # }
#   }
# }

# resource "aws_cloudfront_cache_policy" "example" {
#   name        = "example-policy"
#   comment     = "test comment"
#   default_ttl = 50
#   max_ttl     = 100
#   min_ttl     = 1
#   parameters_in_cache_key_and_forwarded_to_origin {
#     cookies_config {
#       cookie_behavior = "whitelist"
#       cookies {
#         items = ["example"]
#       }
#     }
#     headers_config {
#       header_behavior = "whitelist"
#       headers {
#         items = ["example"]
#       }
#     }
#     query_strings_config {
#       query_string_behavior = "whitelist"
#       query_strings {
#         items = ["example"]
#       }
#     }
#   }
# }