# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :zay,
  ecto_repos: [Zay.Repo]

# Configures the endpoint
config :zay, ZayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9nqgMV+lxOtBpCNZ7JycPXJQQz/6TavddOcPnkChqYdjDHSeTJycfu10IXB04BnM",
  render_errors: [view: ZayWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Zay.PubSub,
  live_view: [signing_salt: "IYC1Yv8W"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:mfa, :request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
