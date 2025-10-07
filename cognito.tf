# --- 1. AWS Cognito User Pool ---
resource "aws_cognito_user_pool" "main" {
  name = "SistemaPedidosUserPool"

  password_policy {
    minimum_length    = 8
    require_lowercase = false
    require_numbers   = false
    require_symbols   = false
    require_uppercase = false
  }

  # Schema Mínimo: Apenas o essencial
  schema {
    name                = "email"
    attribute_data_type = "String"
    mutable             = true
    required            = false # Não é obrigatório
  }

  schema {
    name                     = "custom:cpf"
    attribute_data_type      = "String"
    mutable                  = true
    developer_only_attribute = false
    required                 = false # Não é obrigatório na criação do pool

    string_attribute_constraints {
      min_length = 11
      max_length = 14
    }
  }
}

# --- 2. AWS Cognito User Pool Client (O App Client) ---
resource "aws_cognito_user_pool_client" "main" {
  name                          = "SistemaPedidosAppClient"
  user_pool_id                  = aws_cognito_user_pool.main.id
  generate_secret               = false

  explicit_auth_flows           = ["ADMIN_NO_SRP_AUTH"]
  prevent_user_existence_errors = "ENABLED"

  # Sincronia Perfeita: Peça permissão apenas para o que foi definido no schema
  read_attributes  = [
    "email",
    "custom:cpf"
  ]
  write_attributes = [
    "email",
    "custom:cpf"
  ]

  # Token Settings
  id_token_validity     = 60
  access_token_validity = 60
  token_validity_units {
    id_token      = "minutes"
    access_token  = "minutes"
  }
}

# --- 3. Outputs ---
output "user_pool_id" {
  value = aws_cognito_user_pool.main.id
}

output "client_id" {
  value = aws_cognito_user_pool_client.main.id
}