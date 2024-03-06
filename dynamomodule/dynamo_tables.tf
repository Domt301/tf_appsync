resource "aws_dynamodb_table" "table1" {
  name           = var.table1_name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = "Id"

  attribute {
    name = "Id"
    type = "S"
  }

  tags = var.tags
}

resource "aws_dynamodb_table" "table2" {
  name           = var.table2_name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = "Id"

  attribute {
    name = "Id"
    type = "S"
  }

  tags = var.tags
}
