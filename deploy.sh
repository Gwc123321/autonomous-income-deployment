#!/bin/bash
set -e

echo "===================================="
echo "Autonomous Income Deployment"
echo "===================================="
echo ""

# Check prerequisites
if ! command -v terraform &> /dev/null; then
    echo "Error: Terraform not installed"
    exit 1
fi

if ! command -v aws &> /dev/null; then
    echo "Error: AWS CLI not installed"
    exit 1
fi

# Check AWS credentials
if ! aws sts get-caller-identity &> /dev/null; then
    echo "Error: AWS credentials not configured"
    exit 1
fi

echo "✓ Prerequisites check passed"
echo ""

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

# Validate configuration
echo "Validating configuration..."
terraform validate

# Plan deployment
echo "Planning deployment..."
terraform plan -out=tfplan

read -p "Apply this plan? (yes/no): " confirm

if [ "$confirm" == "yes" ]; then
    echo "Deploying infrastructure..."
    terraform apply tfplan
    
    echo ""
    echo "===================================="
    echo "Deployment Complete!"
    echo "===================================="
    echo ""
    
    # Show outputs
    terraform output
    
    echo ""
    echo "System is now operational and generating income."
else
    echo "Deployment cancelled"
fi
