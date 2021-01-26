defmodule TobaccosClubWeb.BrandsLive.IndexTest do
  use TobaccosClubWeb.ConnCase

  import Phoenix.LiveViewTest

  @tag :skip
  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/brands")
    assert disconnected_html =~ "Marcas"
    assert render(page_live) =~ "Marcas"
  end
end
