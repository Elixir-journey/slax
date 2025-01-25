import Config

# Configure your database
config :slax, Slax.Repo,
  url: System.get_env("DATABASE_URL"),
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: String.to_integer(System.get_env("DATABASE_POOL_SIZE") || "10")

# For development, we disable any cache and enable
# debugging and code reloading.
config :slax, SlaxWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {0, 0, 0, 0}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "DqgMLaFdqHrevXOeSJzQmdxb81OK5241uiUBlXetcUmixDiha+kZgF6XQkmUR062",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:slax, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:slax, ~w(--watch)]}
  ]

# Other configurations remain unchanged.
config :slax, SlaxWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/slax_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

config :slax, dev_routes: true
config :logger, :console, format: "[$level] $message\n"
config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  debug_heex_annotations: true,
  enable_expensive_runtime_checks: true

config :swoosh, :api_client, false
