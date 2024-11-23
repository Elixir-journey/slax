import Config

config :slax, Slax.Repo,
  username: System.get_env("DATABASE_USERNAME") || "postgres",
  password: System.get_env("DATABASE_PASSWORD") || "postgres",
  hostname: System.get_env("DATABASE_HOST") || "localhost",
  database: System.get_env("DATABASE_TEST_NAME") || "slax_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  stacktrace: true,
  show_sensitive_data_on_connection_error: true

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :slax, SlaxWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "A18d3ZoyiSpWvo6Gf8BdCszh8eQd4vzxzhvOGRhEaw4giF2X2lX4ybuvnElz9RBU",
  server: false

# In test we don't send emails
config :slax, Slax.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
