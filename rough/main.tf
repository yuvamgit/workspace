data "aws_availability_zones" "list" {
    all_availability_zones = true
}


output "zone_list" {
    value = data.aws_availability_zones.list.names[4]
}


