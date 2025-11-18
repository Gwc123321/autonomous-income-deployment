# Deployment Guide - Autonomous Income System

## Prerequisites Checklist

- [ ] AWS Account with admin access
- [ ] AWS CLI installed and configured
- [ ] Terraform >= 1.0 installed
- [ ] Git repository cloned
- [ ] terraform.tfvars configured

## Pre-Deployment

### 1. Configure AWS Credentials

```bash
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key
# Set default region: us-east-1
```

### 2. Create S3 Backend Bucket

```bash
aws s3 mb s3://autonomous-income-terraform-state
aws s3api put-bucket-versioning --bucket autonomous-income-terraform-state --versioning-configuration Status=Enabled
```

### 3. Configure Variables

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your settings
```

## Deployment Steps

### Quick Deploy (Automated)

```bash
chmod +x deploy.sh
./deploy.sh
```

### Manual Deploy

```bash
# Initialize
terraform init

# Validate
terraform validate

# Plan
terraform plan -out=tfplan

# Apply
terraform apply tfplan
```

## Post-Deployment

### Verify Deployment

```bash
# Check outputs
terraform output

# Verify ECS cluster
aws ecs describe-clusters --clusters $(terraform output -raw cluster_name)

# Check Lambda function
aws lambda get-function --function-name $(terraform output -raw lambda_function_name)
```

### Access Resources

```bash
# View all outputs
terraform output -json > deployment_info.json
```

## Monitoring

### CloudWatch Dashboard

1. Go to AWS Console → CloudWatch
2. View custom dashboard: "autonomous-income-prod"
3. Monitor metrics in real-time

### Check Logs

```bash
# View Lambda logs
aws logs tail /aws/lambda/autonomous-income-generator --follow

# View ECS logs
aws logs tail /ecs/autonomous-income-cluster --follow
```

## Scaling

### Increase Capacity

```bash
# Edit terraform.tfvars
max_capacity = 20

# Apply changes
terraform apply -auto-approve
```

### Decrease Capacity

```bash
min_capacity = 1
max_capacity = 5
```

## Troubleshooting

### State Lock Issues

```bash
terraform force-unlock <LOCK_ID>
```

### Failed Deployment

```bash
# View error details
terraform show

# Retry
terraform apply
```

### Resource Cleanup

```bash
# Remove all resources
terraform destroy
```

## Cost Monitoring

### View Current Costs

```bash
aws ce get-cost-and-usage \
  --time-period Start=2025-11-01,End=2025-11-30 \
  --granularity MONTHLY \
  --metrics BlendedCost
```

## Update Deployment

```bash
# Pull latest code
git pull

# Review changes
terraform plan

# Apply updates
terraform apply
```

## Emergency Procedures

### Stop All Services

```bash
terraform destroy -target=aws_ecs_cluster.main
```

### Rollback

```bash
# View state history
terraform state list

# Rollback to previous state
terraform state pull > backup.tfstate
```

## Success Criteria

✅ All Terraform resources created
✅ ECS cluster running
✅ Lambda function deployed
✅ CloudWatch alarms active
✅ No errors in logs
✅ Income generation started

## Next Steps

1. Monitor CloudWatch dashboard
2. Review Lambda execution logs
3. Track income metrics
4. Optimize based on performance
5. Scale as needed

## Support

For deployment issues:
- Check Terraform docs: https://terraform.io/docs
- Review AWS documentation
- Open GitHub issue
