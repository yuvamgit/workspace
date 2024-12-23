resource "aws_iam_user" "test_user" {
    for_each = toset(["pavan", "kumar", "ram"])
    name = each.key

    tags = {
      name = each.key
    }
}