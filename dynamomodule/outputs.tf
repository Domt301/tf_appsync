output "table1_name" {
  description = "The name of the first DynamoDB table."
  value       = aws_dynamodb_table.table1.name
}

output "table1_arn" {
  description = "The ARN of the first DynamoDB table."
  value       = aws_dynamodb_table.table1.arn
}

output "table2_name" {
  description = "The name of the second DynamoDB table."
  value       = aws_dynamodb_table.table2.name
}

output "table2_arn" {
  description = "The ARN of the second DynamoDB table."
  value       = aws_dynamodb_table.table2.arn
}
