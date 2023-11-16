# Created iam role for lambda
resource "aws_iam_role" "lambda" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
# create iam policy for cognito that would be attached to lambda iam role
resource "aws_iam_policy" "cognito" {
  name        = "cognito_policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cognito-idp:AdminConfirmSignUp",
          "cognito-idp:AdminCreateUser",
          "cognito-idp:AdminDeleteUser",
          "cognito-idp:AdminGetUser",
          "cognito-idp:AdminInitiateAuth",
          "cognito-idp:AdminUpdateUserAttributes",
          "cognito-idp:CreateUserPoolClient",
          "cognito-idp:ListUserPools",
          "cognito-idp:ListUserPoolClients",
          "cognito-idp:SignUp",
          "cognito-idp:UpdateUserAttributes",
        ]
        Resource = "*"
      }
    ]
  })
}
# the attachmet
resource "aws_iam_role_policy_attachment" "lambda_cognito_attachment" {
  policy_arn = aws_iam_policy.cognito.arn
  role       = aws_iam_role.lambda.name
}
