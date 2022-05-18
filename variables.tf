#######################################
# Instance name
#######################################
variable "name" {}

#######################################
# Input parameters
#######################################
variable "domain" {
  description = "Domain name"
}

variable "iam_user_arns" {
  description = "ARNs of existing IAM users that will be able to assume this role"
  type        = list(any)
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket hosting the static files"
}

variable "cloudfront_distribution_arn" {
  description = "ARN of the static site's Cloudfront distribution"

}

variable "role_path" {
  description = "Optional path of role"
  default     = "/"
}
