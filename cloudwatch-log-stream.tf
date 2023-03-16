resource "aws_cloudwatch_log_stream" "eks_cw_log_stream" {
  name           = var.cloudwatch_log_stream_name
  log_group_name = aws_cloudwatch_log_group.cw_log_group.name
}