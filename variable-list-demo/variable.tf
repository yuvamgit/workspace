variable "demo-user" {
    type = list(string)
    description = "to create iam users in aws mumbai region"
    default = [ "jack" ]
}