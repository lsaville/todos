defmodule Todos.TodoControllerTest do
  use Todos.ConnCase

  test "#index renders a list of todos" do
    conn = build_conn()
    todo = insert(:todo)
    {_, inserted} = Ecto.DateTime.cast(todo.inserted_at)
    {_, updated} = Ecto.DateTime.cast(todo.updated_at)

    conn = get conn, todo_path(conn, :index)

    assert json_response(conn, 200) == %{
      "todos" => [%{
        "title" => todo.title,
        "description" => todo.description,
        "inserted_at" => Ecto.DateTime.to_iso8601(inserted),
        "updated_at" => Ecto.DateTime.to_iso8601(updated)
      }]
    }
  end
end
