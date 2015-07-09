defmodule NotesPhoenix.Router do
  use NotesPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NotesPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/notes", NoteController
  end

  # Other scopes may use custom stacks.
  scope "/api", NotesPhoenix do
    pipe_through :api

    # resources "/notes", NoteApiController
    resources "/lists", ListController
  end
end
