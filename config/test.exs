use Mix.Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :tobaccos_club, TobaccosClub.Repo,
  username: "postgres",
  password: "postgres",
  database: System.get_env("POSTGRES_DB_NAME", "tobaccos_club_test"),
  hostname: System.get_env("POSTGRES_HOST", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tobaccos_club, TobaccosClubWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :ex_aws,
  access_key_id: "AWS_ACCESS_KEY_ID_TEST",
  secret_access_key: "AWS_SECRET_ACCESS_KEY_TEST",
  bucket: "tobaccos_test",
  region: "eu-central-1",
  scheme: "http",
  host: "s3.amazonaws.com"

config :tobaccos_club, TobaccosClub.Mailer, adapter: Swoosh.Adapters.Test
