resource "aws_cognito_user_pool" "vimooz_user_pool" {
  name = "vimooz-user-pool"

  username_attributes = ["email"]
  auto_verified_attributes = ["email"]

  # Define required attributes for users
  schema {
    name = "email"
    attribute_data_type = "String"
    required = true
  }

  schema {
    name = "name"
    attribute_data_type = "String"
    required = true
  }

  # Password policy
  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = false
  }

  # Enable email verification for self-signed up users
  verification_message_template {
    default_email_option = "CONFIRM_WITH_LINK"
    email_subject = "Verify your email"
    email_message = "Please click the following link to verify your email: https://example.com/verify?token={####}"
    email_message_by_link = "Please click the following link to verify your email: https://example.com/verify?token={####}."
  }
}

resource "aws_cognito_user_pool_client" "vimooz_user_pool_client" {
  name         = "example-user-pool-client"
  user_pool_id = aws_cognito_user_pool.vimooz_user_pool.id

  # Enable email and username as sign-in options for users
  supported_identity_providers            = ["COGNITO"]
  allowed_oauth_flows_user_pool_client   = true
  allowed_oauth_flows                   = ["code"]
  allowed_oauth_scopes                   = ["openid", "email", "profile"]
  callback_urls                          = ["http://localhost:3000"] # Change to your desired callback URL
}

resource "aws_cognito_user_pool_client" "vimooz_user_pool_app_client" {
  name         = "vimooz-user-pool-app-client"
  user_pool_id = aws_cognito_user_pool.vimooz_user_pool.id

  # Enable email and username as sign-in options for users
  supported_identity_providers            = ["COGNITO"]
  allowed_oauth_flows_user_pool_client   = true
  allowed_oauth_flows                   = ["implicit"]
  allowed_oauth_scopes                   = ["openid", "email", "profile"]
  callback_urls                          = ["http://localhost:3000"] # Change to your desired callback URL
  logout_urls                            = ["http://localhost:3000/logout"] # Change to your desired logout URL
}
