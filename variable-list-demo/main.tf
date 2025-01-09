resource "aws_iam_user" "users" {
    for_each = toset(var.demo-user)
    name = each.value
}