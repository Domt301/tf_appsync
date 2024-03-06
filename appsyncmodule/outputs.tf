output "appsync_api_url" {
  value = aws_appsync_graphql_api.api.uris["GRAPHQL"]
}

output "appsync_api_key" {
  value = aws_appsync_api_key.api_key.id
}
