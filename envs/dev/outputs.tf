output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "instance_public_ip" {
  description = "The public IP address of the web server"
  value       = module.ec2.public_ip
}

output "website_url" {
  description = "Click here to see your web server!"
  value       = "http://${module.ec2.public_ip}"
}

output "instance_id" {
  description = "Instance ID for SSM connection"
  value       = module.ec2.instance_id
}