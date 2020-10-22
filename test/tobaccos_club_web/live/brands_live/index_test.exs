defmodule TobaccosClubWeb.BrandsLive.IndexTest do
  use TobaccosClubWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/brands")
    assert disconnected_html =~ "Tobacco"
    assert render(page_live) =~ "Brands"
  end
end
