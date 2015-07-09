defmodule NotesPhoenix.ListView do
  use NotesPhoenix.Web, :view

  def render("index.json", %{lists: lists}) do
    %{data: render_many(lists, "list.json")}
  end

  def render("show.json", %{list: list}) do
    %{data: render_one(list, "list.json")}
  end

  def render("list.json", %{list: list}) do
    %{id: list.id}
  end
end
