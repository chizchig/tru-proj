# resource "aws_dynamodb_table" "verification_tokens" {
#   name           = "verification_tokens"
#   billing_mode   = "PROVISIONED"
#   read_capacity  = 5
#   write_capacity = 5

#   attribute {
#     name = "token"
#     type = "S"
#   }

#   attribute {
#     name = "email"
#     type = "S"
#   }

#   attribute {
#     name = "expiration_time"
#     type = "S"
#   }

#   global_secondary_index {
#     name               = "email-index"
#     hash_key           = "email"
#     projection_type    = "ALL"
#     read_capacity      = 1
#     write_capacity     = 1
#   }

#   global_secondary_index {
#     name               = "expiration-time-index"
#     hash_key           = "expiration_time"
#     projection_type    = "ALL"
#     read_capacity      = 5
#     write_capacity     = 5
#   }
# }

resource "aws_dynamodb_table" "verification_tokens" {
  name           = "verification-tokens"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "email"
    type = "S"
  }

  attribute {
    name = "token"
    type = "S"
  }

  hash_key = "email"
  range_key = "token"

  # Define a GSI for the "token" attribute
  global_secondary_index {
    name = "token-index"
    hash_key = "token"
    projection_type = "ALL"
  }
}


