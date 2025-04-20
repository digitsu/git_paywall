import Config

config :git_paywall, GitPaywall.Repo,
  database: "git_paywall_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :git_paywall, GitPaywallWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  secret_key_base: "replace_with_secure_key"

config :git_paywall, :bsv,
  network: :mainnet,
  explorer_url: "https://api.whatsonchain.com/v1/bsv/main"

import_config "#{config_env()}.exs"
