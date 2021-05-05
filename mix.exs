defmodule Zay.MixProject do
  use Mix.Project

  def project do
    [
      app: :zay,
      version: "0.0.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      mod: {Zay.Application, []},
      applications: [
        :logger,
        :plug_cowboy,
        :ecto,
        :postgrex,
        :ecto_sqlite3
      ],
      extra_applications: [:exsync]
    ]
  end

  defp deps do
    [
      # web
      {:cowboy, "~> 2.8"},
      {:plug_cowboy, "~> 2.5"},
      # .json
      {:poison, "~> 4.0"},
      # todo: {:jason, "~> 1.2"},
      # ecto
      {:ecto, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:ecto_sqlite3, "~> 0.5.5"},
      # dev tools
      {:exsync, "~> 0.2", only: :dev}
    ]
  end

  defp aliases do
    [
      test: "test --no-start"
    ]
  end
end
