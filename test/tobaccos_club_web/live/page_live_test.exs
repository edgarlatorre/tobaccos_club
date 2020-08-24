defmodule TobaccosClubWeb.PageLiveTest do
  use TobaccosClubWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Tobaccos Club"
    assert render(page_live) =~ "Brands"
  end
end
