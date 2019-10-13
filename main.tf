resource "aws_backup_plan" "default" {
  name  = var.name

  rule {
    rule_name           = "${var.name}-default"
    target_vault_name   = "Default"
    schedule            = var.schedule
    start_window        = var.start_window
    completion_window   = var.completion_window
    recovery_point_tags = var.tags

    dynamic "lifecycle" {
      for_each = var.cold_storage_after != null || var.delete_after != null ? ["true"] : []
      content {
        cold_storage_after = var.cold_storage_after
        delete_after       = var.delete_after
      }
    }
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "default" {
  name               = var.name
  assume_role_policy = join("", data.aws_iam_policy_document.assume_role.*.json)
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "default" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = join("", aws_iam_role.default.*.name)
}

resource "aws_backup_selection" "default" {
  iam_role_arn = "${aws_iam_role.default.arn}"
  name         = var.name
  plan_id      = "${aws_backup_plan.default.id}"

  dynamic "selection_tag" {
    for_each = var.selection_by_tags
      content {
        type  = "STRINGEQUALS"
        key   = selection_tag.key
        value = selection_tag.value
      }
  }
}