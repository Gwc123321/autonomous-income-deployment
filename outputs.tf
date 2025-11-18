# Outputs for Autonomous Income Deployment

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "ecs_cluster_name" {
  description = "Name of ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "ecs_cluster_arn" {
  description = "ARN of ECS cluster"
  value       = aws_ecs_cluster.main.arn
}

output "lambda_function_arn" {
  description = "ARN of income generator Lambda function"
  value       = aws_lambda_function.income_generator.arn
}

output "lambda_function_name" {
  description = "Name of income generator Lambda function"
  value       = aws_lambda_function.income_generator.function_name
}

output "dynamodb_table_name" {
  description = "Name of DynamoDB state table"
  value       = aws_dynamodb_table.income_state.name
}

output "s3_bucket_name" {
  description = "Name of S3 data bucket"
  value       = aws_s3_bucket.data.bucket
}

output "deployment_info" {
  description = "Deployment information"
  value = {
    region      = var.aws_region
    environment = var.environment
    timestamp   = timestamp()
  }
}
