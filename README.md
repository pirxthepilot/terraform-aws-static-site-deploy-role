# terraform-aws-static-site-deploy-role

Deploys an IAM role that has just enough access to manage a Cloudfront + S3 static site. Works best with sites deployed using [terraform-aws-static-site](https://github.com/pirxthepilot/terraform-aws-static-site).

Permissions can be reviewed [here](./policies.tf).


## Usage

**Note:** The IAM user/s that will be allowed to assume the role must already exist!

Basic usage:

```
module "mysite_deploy_role" {
  source = "./modules/terraform-aws-static-site-deploy-role"
  name   = "mysite_deploy_role"

  domain                      = "example.com"
  iam_user_arns               = ["arn:aws:iam::111111111111:user/user1", "arn:aws:iam::111111111111:user/user2"]
  s3_bucket_arn               = "arn:aws:s3:::example.com"
  cloudfront_distribution_arn = "12345678"
}
```

Used with [terraform-aws-static-site](https://github.com/pirxthepilot/terraform-aws-static-site):

```
module "mysite" {
  source = "./modules/terraform-aws-static-site"
  name   = "mysite"

  domain               = var.domain
  subdomains           = var.subdomains
  route53_zone_id      = var.route53_zone_id
}

module "mysite_deploy_role" {
  source = "./modules/terraform-aws-static-site-deploy-role"
  name   = "mysite_deploy_role"

  domain                      = var.domain
  iam_user_arns               = ["arn:aws:iam::111111111111:user/user1", "arn:aws:iam::111111111111:user/user2"]
  s3_bucket_arn               = module.mysite.s3_bucket_arn
  cloudfront_distribution_arn = module.mysite.cloudfront_distribution_arn
}
```

After deploy, add the resulting role ARN to your IAM profile, e.g.:

```
[profile deploy]
region=us-west-2
role_arn=arn:aws:iam::111111111111:role/deploy-example-com-20220429042026215200000001
```
