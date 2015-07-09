defmodule NotesPhoenix.ListController do
  use NotesPhoenix.Web, :controller

  alias NotesPhoenix.List

  plug :scrub_params, "list" when action in [:create, :update]

  def index(conn, _params) do
    lists = Repo.all(List)
    render(conn, "index.json", lists: lists)
  end

  def create(conn, %{"list" => list_params}) do
    changeset = List.changeset(%List{}, list_params)

    if changeset.valid? do
      list = Repo.insert!(changeset)
      render(conn, "show.json", list: list)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(NotesPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    list = Repo.get!(List, id)
    render conn, "show.json", list: list
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Repo.get!(List, id)
    changeset = List.changeset(list, list_params)

    if changeset.valid? do
      list = Repo.update!(changeset)
      render(conn, "show.json", list: list)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(NotesPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Repo.get!(List, id)

    list = Repo.delete!(list)
    render(conn, "show.json", list: list)
  end
end
