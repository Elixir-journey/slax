defmodule SlaxWeb.PageControllerTest do
  use SlaxWeb.ConnCase

  setup do
    room = %Slax.Chat.Room{name: "General", topic: "Welcome!"} |> Slax.Repo.insert!()
    :ok
  end

  test "GET / renders application's name", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Slax"
  end

  test "GET / renders rooms label", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Rooms"
  end
end
