defmodule Zay.Repo do
  use Ecto.Repo,
    otp_app: :zay,
    adapter: Ecto.Adapters.Postgres
end
