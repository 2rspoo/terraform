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

  # --- CORREÇÃO FINAL APLICADA AQUI ---
  # Adicionamos TODOS os schemas para os atributos padrão que o client precisa ler.
  # Todos são marcados como não obrigatórios.
  schema {
    name                = "email"
    attribute_data_type = "String"
    mutable             = true
    required            = false
  }

  schema {
    name                = "name"
    attribute_data_type = "String"
    mutable             = true
    required            = false
  }

  schema {
    name                = "family_name"
    attribute_data_type = "String"
    mutable             = true
    required            = false
  }

  schema {
    name                = "given_name"
    attribute_data_type = "String"
    mutable             = true
    required            = false
  }

  # Seu schema customizado
  schema {
    name                     = "custom:cpf"
    attribute_data_type      = "String"
    mutable                  = true
    developer_only_attribute = false

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

  # Esta lista agora corresponde 100% ao que foi declarado no schema do User Pool
  read_attributes  = [
    "sub",
    "custom:cpf",
    "email",
    "name",
    "family_name",
    "given_name"
  ]

  write_attributes = [
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

# --- 3. (Opcional) Outputs ---
output "user_pool_id" {
  value = aws_cognito_user_pool.main.id
}

output "client_id" {
  value = aws_cognito_user_pool.main.id
}