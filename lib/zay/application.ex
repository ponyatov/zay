defmodule Zay.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Zay.Repo, []},
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Zay.Endpoint,
        options: [port: 22041]
      )
    ]

    opts = [strategy: :one_for_one, name: Zay.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
