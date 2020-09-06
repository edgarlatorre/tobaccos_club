defmodule TobaccosClubWeb.PageLiveTest do
  use TobaccosClubWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Tobacco"
    assert render(page_live) =~ "Blends"
  end
end
