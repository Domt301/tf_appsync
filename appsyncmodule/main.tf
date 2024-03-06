resource "aws_appsync_graphql_api" "api" {
  name                = var.api_name
  authentication_type = "API_KEY"

  schema = file("${path.module}/schema.graphql")
}

resource "aws_iam_policy" "dynamodb_access" {
  name        = "DynamoDBAccessPolicy"
  description = "Policy for AppSync to access DynamoDB tables"
  policy      = file("${path.module}/dynamodb_access_policy.json")
}

resource "aws_iam_role" "appsync_dynamodb_role" {
  name = "AppSyncDynamoDBAccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "appsync.amazonaws.com"
        },
        Effect = "Allow",
        Sid = ""
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "appsync_dynamodb_access" {
  role       = aws_iam_role.appsync_dynamodb_role.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}



resource "aws_appsync_datasource" "dynamodb_table1" {
  api_id = aws_appsync_graphql_api.api.id
  name   = var.dynamodb_table1_name
  type   = "AMAZON_DYNAMODB"
  service_role_arn = aws_iam_role.appsync_dynamodb_role.arn
  dynamodb_config {
    table_name = var.dynamodb_table1_name
 
  }
}

resource "aws_appsync_datasource" "dynamodb_table2" {
  api_id = aws_appsync_graphql_api.api.id
  name   = var.dynamodb_table2_name
  type   = "AMAZON_DYNAMODB"
  service_role_arn = aws_iam_role.appsync_dynamodb_role.arn
  dynamodb_config {
    table_name = var.dynamodb_table2_name
 
  }
}

resource "aws_appsync_resolver" "resolver_table1" {
  api_id      = aws_appsync_graphql_api.api.id
  type        = "Query"
  field       = "getTable1Item"
  data_source = aws_appsync_datasource.dynamodb_table1.name

  request_template  = file("${path.module}/request_template_table1.vtl")
  response_template = file("${path.module}/response_template.vtl")
}

resource "aws_appsync_resolver" "resolver_table2" {
  api_id      = aws_appsync_graphql_api.api.id
  type        = "Query"
  field       = "getTable2Item"
  data_source = aws_appsync_datasource.dynamodb_table2.name

  request_template  = file("${path.module}/request_template_table2.vtl")
  response_template = file("${path.module}/response_template.vtl")
}

resource "aws_appsync_api_key" "api_key" {
  api_id = aws_appsync_graphql_api.api.id
  expires = "2024-04-14T00:00:00Z" # Adjust the expiration date as needed
}
