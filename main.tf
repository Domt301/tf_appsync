provider "aws" {
  region = "us-east-1" # Change this to your preferred AWS region
}

module "aws_dynamodb_table" {
  source = "./dynamomodule"
  table1_name = "table1"
  table2_name = "table2"
  read_capacity = 20
  write_capacity = 20
  tags = {
    Environment = "dev"
  }
  
}

module "aws_appsync" {
  source = "./appsyncmodule"
  api_name = "appsync-api"
  dynamodb_table1_name = module.aws_dynamodb_table.table1_name
  dynamodb_table2_name = module.aws_dynamodb_table.table2_name
  region = "us-east-1"
}
  
