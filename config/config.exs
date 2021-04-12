use Mix.Config

config :zay,
  ecto_repos: [Zay.Repo]

# Configures the endpoint
config :zay, ZayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0Sbq7vR3huJCSE7YlYWMisxB+OQapgOs+wu9g/Hlt7tUK7KncWL5w0llO2AK17Gf",
  render_errors: [view: ZayWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Zay.PubSub,
  live_view: [signing_salt: "sv25ryuU"]

config :logger, :console,
  format: "$date $time $metadata [$level] $levelpad$message\n",
  metadata: [:pid, :mfa]

# metadata: :all

config :phoenix, :json_library, Jason

config :exsync, logging_enabled: false, src_monitor: true

import_config "#{Mix.env()}.exs"
