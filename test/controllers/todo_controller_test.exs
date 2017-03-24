defmodule Todos.TodoControllerTest do
  use Todos.ConnCase

  test "#index renders a list of todos" do
    conn = build_conn()
    todo = insert(:todo)
#    {_, inserted} = Ecto.DateTime.cast(todo.inserted_at)
#    {_, updated} = Ecto.DateTime.cast(todo.updated_at)

    conn = get conn, todo_path(conn, :index)

    assert json_response(conn, 200) == %{
      "todos" => [%{
        "title"       => todo.title,
        "description" => todo.description,
        "inserted_at" => NaiveDateTime.to_iso8601(todo.inserted_at),
        "updated_at"  => NaiveDateTime.to_iso8601(todo.updated_at)
      }]
    }
  end

  test "#show renders a single todo" do
    conn = build_conn()
    todo = insert(:todo)

    conn = get conn, todo_path(conn, :show, todo)

    assert json_response(conn, 200) == %{
      "todo" => %{
        "title"       => todo.title,
        "description" => todo.description,
        "inserted_at" => NaiveDateTime.to_iso8601(todo.inserted_at),
        "updated_at"  => NaiveDateTime.to_iso8601(todo.updated_at)
      }
    }
  end
end
