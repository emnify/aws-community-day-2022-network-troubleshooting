#####################
# Flow Log CloudWatch
#####################
resource "aws_cloudwatch_log_group" "flow_log" {
  name              = "vpc-flow-logs-trouble-${data.aws_region.current.name}"
  retention_in_days = var.flow_log_cloudwatch_log_group_retention_in_days

  tags = merge(var.tags)
}

#########################
# Flow Log CloudWatch IAM
#########################
resource "aws_iam_role" "vpc_flow_log_cloudwatch" {
  name_prefix        = "vpc-flow-log-role-${data.aws_region.current.name}-"
  assume_role_policy = data.aws_iam_policy_document.flow_log_cloudwatch_assume_role.json

  tags = merge(var.tags)
}

data "aws_iam_policy_document" "flow_log_cloudwatch_assume_role" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    effect = "Allow"

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "vpc_flow_log_cloudwatch" {
  role       = aws_iam_role.vpc_flow_log_cloudwatch.name
  policy_arn = aws_iam_policy.vpc_flow_log_cloudwatch.arn
}

resource "aws_iam_policy" "vpc_flow_log_cloudwatch" {
  name_prefix = "vpc-flow-log-to-cloudwatch-"
  policy      = data.aws_iam_policy_document.vpc_flow_log_cloudwatch.json
}

data "aws_iam_policy_document" "vpc_flow_log_cloudwatch" {
  statement {
    sid = "AWSVPCFlowLogsPushToCloudWatch"

    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}