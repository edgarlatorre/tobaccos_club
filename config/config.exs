# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

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

config :gettext, default_locale: "pt", locales: ~w(en pt)

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
