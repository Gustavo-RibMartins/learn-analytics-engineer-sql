terraform {
  backend "s3" {
    bucket = "gusribm-526554803206-terraform-backend"
    key    = "learn-eng-anl-sql.tfstate"
    region = "us-east-1"
  }
}