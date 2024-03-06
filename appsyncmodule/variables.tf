variable "api_name" {
  description = "The name of the AppSync API"
  type        = string
}

variable "dynamodb_table1_name" {
  description = "The name of the first DynamoDB table"
  type        = string
}

variable "dynamodb_table2_name" {
  description = "The name of the second DynamoDB table"
  type        = string
}

variable "region" {
  description = "The region in which the resources will be created"
  type        = string
}