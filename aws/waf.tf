# resource "aws_wafv2_web_acl" "waf" {
#   name        = "devpart-managed-rule"
#   description = "devpart of a managed rule."
#   scope       = "REGIONAL"

#   default_action {
#     allow {}
#   }

#   rule {
#     name     = "rule-1"
#     priority = 1

#     override_action {
#       count {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWSManagedRulesCommonRuleSet"
#         vendor_name = "AWS"

#         rule_action_override {
#           action_to_use {
#             count {}
#           }

#           name = "SizeRestrictions_QUERYSTRING"
#         }

#         rule_action_override {
#           action_to_use {
#             count {}
#           }

#           name = "NoUserAgent_HEADER"
#         }

#         scope_down_statement {
#           geo_match_statement {
#             country_codes = ["US", "NL"]
#           }
#         }
#       }
#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = false
#       metric_name                = "devpart-rule-metric-name"
#       sampled_requests_enabled   = false
#     }
#   }

#   tags = {
#     Name = "devPart_waf"
#     MN = "devPart"
#   }
#   visibility_config {
#     cloudwatch_metrics_enabled = false
#     metric_name                = "devpart-rule-metric-name"
#     sampled_requests_enabled   = false
#   }
# }

resource "aws_waf_web_acl" "service_launcher_bucket" {

  name        = "devpartWebACL"
  metric_name = "devpartWebACL"

  default_action {
    type = "ALLOW"
  }

#   rules {
#     action {
#       type = "BLOCK"
#     }

#     priority = 1
#     rule_id  = aws_waf_rule.wafrule.id
#     type     = "REGULAR"
#   }
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "devPart_waf"
    MN = "devPart"
  }
}

