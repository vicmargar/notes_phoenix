require Logger

defmodule NotesPhoenix.NoteApiController do
  use NotesPhoenix.Web, :controller

  alias NotesPhoenix.Note

  def index(conn, _params) do
    Logger.debug inspect(conn)
    notes = Repo.all(Note)
    Phoenix.Controller.render(conn, "index.json", notes: notes)
  end
end
