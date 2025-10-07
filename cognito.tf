# --- 1. AWS Cognito User Pool ---
resource "aws_cognito_user_pool" "main" {
  name = "SistemaPedidosUserPool"

  # Configurações de login: Usar CPF como atributo customizado.
  # Note: Não estamos usando email/username padrão para login, o fluxo é
  # gerenciado totalmente pela Lambda via CPF.
  alias_attributes = ["email"] # Opcional: manter o email como alias de login

  # Define as políticas de senha. Como o fluxo é 'passwordless',
  # essas políticas não são tão críticas, mas precisam ser configuradas.
  # Exemplo: Sem exigência de senha forte/mínima (você pode ajustar).
  password_policy {
    minimum_length    = 8
    require_lowercase = false
    require_numbers   = false
    require_symbols   = false
    require_uppercase = false
  }

  # Desativa o envio de emails de verificação, pois o fluxo de auth é customizado.
  auto_verified_attributes = ["email"]

  # Schema (Atributos): Onde definimos o 'cpf' como atributo customizado.
  schema {
    name                     = "cpf"
    attribute_data_type      = "String"
    mutable                  = true # Permite que o atributo seja modificado após a criação do usuário
    developer_only_attribute = false # Torna visível para todas as APIs

    # Restrições de tamanho
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
  generate_secret               = false # Desnecessário para este fluxo e mais simples
  explicit_auth_flows           = ["ADMIN_NO_SRP_AUTH"] # ESSENCIAL! Permite o fluxo de auth da sua Lambda (admin_initiate_auth)

  # Desativa o envio de credenciais de login para endpoints que não são usados
  prevent_user_existence_errors = "ENABLED"

  required_claims = [
    "cpf"
  ]

  # Tempo de vida dos tokens (ajuste conforme a necessidade de segurança/experiência do usuário)
  id_token_validity     = 60 # Minutos
  access_token_validity = 60 # Minutos
  token_validity_units {
    id_token      = "minutes"
    access_token  = "minutes"
  }
}

# --- 3. (Opcional) Referências para usar em outros módulos Terraform (Outputs) ---
output "user_pool_id" {
  value = aws_cognito_user_pool.main.id
}

output "client_id" {
  value = aws_cognito_user_pool_client.main.id
}