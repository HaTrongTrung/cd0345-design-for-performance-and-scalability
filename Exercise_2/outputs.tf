# TODO: Define the output variable for the lambda function.
output "greeting" {
  description = "First lambda function"
  value       = "module.lambda_by_terraform.output"
}
