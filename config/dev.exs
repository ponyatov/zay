use Mix.Config

config :exsync, src_monitor: true

config :zay, Zay.Repo, database: "tmp/dev.db"
