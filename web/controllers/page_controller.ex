defmodule NotesPhoenix.PageController do
  use NotesPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
