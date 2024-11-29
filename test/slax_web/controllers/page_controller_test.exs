defmodule SlaxWeb.PageControllerTest do
  use SlaxWeb.ConnCase

  test "GET / renders the correct default room name", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "#room-name Unknown"
  end
end
