resource "aws_iam_user" "test_user" {
    for_each = tomap ({
      test = "pavan"
      dev = "kumar"
      prod = "ram"
    })
    
    name = each.value

    tags = {
      Environment = each.key
    }
}