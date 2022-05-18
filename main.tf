#######################################
# Role and Policy Attachment
#######################################

resource "aws_iam_role" "static_site_deploy" {
  name_prefix        = "deploy-${replace(var.domain, ".", "-")}-"
  path               = var.role_path
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_policy" "role_permissions" {
  name_prefix = "DeployStaticSite-${var.domain}-"

  policy = data.aws_iam_policy_document.role_permissions.json
}

resource "aws_iam_role_policy_attachment" "role_permissions" {
  role       = aws_iam_role.static_site_deploy.name
  policy_arn = aws_iam_policy.role_permissions.arn
}
