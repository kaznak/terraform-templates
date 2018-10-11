
# Terraform Templates

Terraform Cloud Deployment Templates.

## Templates
### [route53](./template/route53)
Route 53 Settings.
Nameserver advertising takes time.
Therefore it shoud be seperated from main site deployment scripts.

### [ec2](./template/ec2)
Simple EC2 only environment.

### [ec2-rds](./template/ec2-rds)
Simple EC2 and RDS environment.
This is suitable for web applications.

## Dependency

+ [Terraform](https://www.terraform.io/)
+ [python aws-mfa](https://pypi.org/project/aws-mfa/)
