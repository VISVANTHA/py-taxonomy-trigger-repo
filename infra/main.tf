# Scanner bait only. Not deployed. Gives checkov / tfsec / kics IaC files
# so Testable can score the eight B1 taxonomy leaves instead of N/A.

terraform {
  required_version = ">= 1.0"
}

# Open Firewall / Open Security Group (CKV_AWS_24, CKV_AWS_23)
resource "aws_security_group" "open_ssh" {
  name        = "trigger-open-ssh"
  description = "Intentional 0.0.0.0/0 SSH for IaC scanners"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Public Storage (CKV_AWS_20, CKV_AWS_53–56)
resource "aws_s3_bucket" "public" {
  bucket = "trigger-public-bucket-not-real"
  acl    = "public-read"
}

resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.public.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Unencrypted Storage (CKV_AWS_19 missing S3 SSE, CKV_AWS_16 RDS, CKV_AWS_3 EBS)
resource "aws_db_instance" "unencrypted" {
  identifier          = "trigger-unencrypted-db"
  engine              = "mysql"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  username            = "trigger"
  password            = "not-a-real-password"
  skip_final_snapshot = true
  publicly_accessible = true
  storage_encrypted   = false
}

resource "aws_ebs_volume" "unencrypted" {
  availability_zone = "us-east-1a"
  size              = 8
  encrypted         = false
}
