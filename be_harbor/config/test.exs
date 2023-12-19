import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :be_harbor, BeHarbor.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "be_harbor_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :be_harbor, BeHarborWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ARX+IqELmH2fgiBiiR8cEFPrA2Ovy41nQBFaMHcIMifklyc0GEd/CiIq4ZHZ8j6Z",
  server: false

# In test we don't send emails.
config :be_harbor, BeHarbor.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
