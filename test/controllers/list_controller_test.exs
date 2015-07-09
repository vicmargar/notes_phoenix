defmodule NotesPhoenix.ListControllerTest do
  use NotesPhoenix.ConnCase

  alias NotesPhoenix.List
  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, list_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    list = Repo.insert! %List{}
    conn = get conn, list_path(conn, :show, list)
    assert json_response(conn, 200)["data"] == %{
      "id" => list.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, list_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, list_path(conn, :create), list: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(List, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, list_path(conn, :create), list: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    list = Repo.insert! %List{}
    conn = put conn, list_path(conn, :update, list), list: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(List, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    list = Repo.insert! %List{}
    conn = put conn, list_path(conn, :update, list), list: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    list = Repo.insert! %List{}
    conn = delete conn, list_path(conn, :delete, list)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(List, list.id)
  end
end
