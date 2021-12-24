# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :tobaccos_club,
  ecto_repos: [TobaccosClub.Repo]

# Configures the endpoint
config :tobaccos_club, TobaccosClubWeb.Endpoint,
  url: [host: "127.0.0.1"],
  secret_key_base:
    System.get_env("SECRET_KEY_BASE") ||
      "iMGDqVp285quNur7Kygqe135lvyK5diVfXcwk0np+mEKBNe4WTD2yBP8fx399MoT",
  render_errors: [view: TobaccosClubWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TobaccosClub.PubSub,
  live_view: [signing_salt: "/kbfh/W1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Set default locale
config :gettext, locales: ~w(en pt es), default_locale: "pt"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Email for contact
config :tobaccos_club, contact_email: System.get_env("CONTACT_EMAIL")

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
