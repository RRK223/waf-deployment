# Well-Architected Framework for AWS Account

This document outlines baseline AWS account best practices aligned with the AWS Well-Architected Framework to ensure security, reliability, operational excellence, and cost control.

---

## 1. Security & Identity Management

1. Enable MFA for all IAM users
2. Avoid using the root account for daily operations
3. Secure the root account
   - Enable MFA on root
   - Do not create access keys for root
   - Store root credentials securely (offline)
4. Use IAM roles instead of long-lived access keys wherever possible
5. Follow the principle of least privilege for all IAM policies
6. Use IAM groups to manage permissions instead of attaching policies directly to users
7. Rotate access keys regularly if access keys are required
8. Enable AWS IAM Access Analyzer to detect overly permissive policies
9. Enable AWS Organizations SCPs (if using multiple accounts) to enforce guardrails

---

## 2. Account & Region Management

1. Only enable AWS regions that are planned to be used
2. Disable or restrict unused regions to reduce attack surface
3. Use separate accounts for different environments (e.g. dev, staging, prod)
4. Apply Service Control Policies (SCPs) to prevent accidental misuse of services
5. Define naming conventions for accounts and resources

---

## 3. Network & Resource Baseline

1. Delete default resources such as:
   - Default VPC
   - Default subnets
   - Default security groups
2. Create custom VPCs with clear CIDR planning
3. Restrict inbound traffic using security groups and NACLs
4. Avoid using `0.0.0.0/0` unless strictly required
5. Use private subnets for backend services and databases
6. Enable VPC Flow Logs for network visibility

---

## 4. Logging, Monitoring & Auditing

1. Enable AWS CloudTrail in all regions
2. Store CloudTrail logs in a dedicated S3 bucket with restricted access
3. Enable AWS Config to track configuration changes
4. Enable CloudWatch logs and metrics for critical services
5. Configure CloudWatch alarms for:
   - Unauthorized API calls
   - Root account usage
   - Billing anomalies
6. Centralize logs if using multiple accounts

---

## 5. Operational Excellence

1. Use Infrastructure as Code (Terraform/CloudFormation) for all resources
2. Avoid manual resource creation in the AWS Console
3. Version control all infrastructure code
4. Use CI/CD pipelines for infrastructure deployment
5. Tag all resources with:
   - Environment
   - Owner
   - Project
6. Maintain documentation and runbooks for critical systems

---

## 6. Reliability & Resilience

1. Design for failure using multiple Availability Zones
2. Use health checks and monitoring for services
3. Automate recovery where possible
4. Regularly test backup and restore procedures
5. Use Elastic IPs or Load Balancers appropriately
6. Avoid single points of failure

---

## 7. Cost Management & Optimization

1. Enable AWS Cost Explorer
2. Set up billing alarms and budgets
3. Use right-sized EC2 instances
4. Avoid running unused or idle resources
5. Use auto-scaling where applicable
6. Review costs regularly and clean up unused resources
7. Prefer managed services when they reduce operational overhead

---

## 8. Sustainability & Clean Architecture

1. Avoid overprovisioning resources
2. Shut down non-production environments when not in use
3. Use automation to reduce manual intervention
4. Reuse infrastructure patterns and modules
5. Periodically review architecture for simplification

---

## 9. Governance & Compliance (Optional but Recommended)

1. Enable AWS Security Hub
2. Enable GuardDuty for threat detection
3. Define incident response procedures
4. Conduct regular security and architecture reviews

---

## Outcome

Following this framework ensures:
- Secure and controlled AWS accounts
- Predictable and repeatable infrastructure
- Reduced operational risk
- Cost-efficient and scalable architecture

