# --- 1. AWS Cognito User Pool ---
resource "aws_cognito_user_pool" "main" {
  name = "SistemaPedidosUserPool"

  # **MUDANÇA CRÍTICA:** Remove 'email' de alias_attributes.
  # Nenhuma configuração de alias é necessária, pois a autenticação é customizada pelo CPF.
  # alias_attributes = ["email"] # LINHA REMOVIDA

  # Políticas de senha: Manter o mínimo é bom, pois não será usada.
  password_policy {
    minimum_length    = 8
    require_lowercase = false
    require_numbers   = false
    require_symbols   = false
    require_uppercase = false
  }

  # **MUDANÇA CRÍTICA:** Remove 'email' de auto_verified_attributes.
  # Nenhum atributo será auto-verificado, pois a verificação será via Lambda Custom Auth.
  # auto_verified_attributes = ["email"] # LINHA REMOVIDA

  # Schema (Atributos): Definindo APENAS o CPF.
  schema {
    name                     = "custom:cpf"
    attribute_data_type      = "String"
    mutable                  = true
    developer_only_attribute = false

    # O CPF é o identificador central, e você pode torná-lo obrigatório
    # *APÓS* a criação inicial (conforme a limitação da AWS).
    # Por enquanto, mantemos limpo, mas ele é usado como login customizado.
    # required                 = true # Mantenha removido para evitar o erro 400 da AWS na criação

    string_attribute_constraints {
      min_length = 11
      max_length = 14
    }
  }


}

# --- 2. AWS Cognito User Pool Client (O App Client) ---
# --- 2. AWS Cognito User Pool Client (O App Client) ---
resource "aws_cognito_user_pool_client" "main" {
  name                          = "SistemaPedidosAppClient"
  user_pool_id                  = aws_cognito_user_pool.main.id
  generate_secret               = false

  explicit_auth_flows           = ["ADMIN_NO_SRP_AUTH"]
  prevent_user_existence_errors = "ENABLED"

  # CORREÇÃO ESSENCIAL: O Cognito exige que atributos padrão sejam incluídos.
  # Adicione 'email' e outros atributos padrões que seu User Pool possui/pode usar.
  read_attributes  = [
    "sub", # O ID único do usuário (sempre presente e útil)
    "custom:cpf"

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
  value = aws_cognito_user_pool_client.main.id
}