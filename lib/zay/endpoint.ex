defmodule Zay.Endpoint do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  defp localtime do
    {date, time} = :calendar.local_time()
    inspect(%{date: date, time: time})
  end

  get "/ping" do
    send_resp(conn, 200, "pong @ #{localtime}")
  end

  get "/localtime" do
    send_resp(conn, 200, localtime)
  end

  match _ do
    send_resp(conn, 404, inspect(conn))
  end
end
