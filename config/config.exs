use Mix.Config

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  level: :debug

config :zay, ecto_repos: [Zay.Repo]

import_config "#{Mix.env()}.exs"
