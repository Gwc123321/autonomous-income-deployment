# Variables for Autonomous Income Deployment

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "instance_type" {
  description = "EC2 instance type for workers"
  type        = string
  default     = "t3.medium"
}

variable "min_capacity" {
  description = "Minimum number of instances"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Maximum number of instances"
  type        = number
  default     = 10
}

variable "enable_auto_healing" {
  description = "Enable automatic healing of failed components"
  type        = bool
  default     = true
}

variable "income_target_monthly" {
  description = "Monthly income target in USD"
  type        = number
  default     = 10000
}

variable "deployment_strategy" {
  description = "Deployment strategy: blue-green or rolling"
  type        = string
  default     = "rolling"
}

variable "monitoring_enabled" {
  description = "Enable comprehensive monitoring"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project     = "AutonomousIncome"
    ManagedBy   = "Terraform"
    AutoHealing = "Enabled"
  }
}
