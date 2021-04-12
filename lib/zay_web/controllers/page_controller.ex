defmodule ZayWeb.PageController do
  use ZayWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
