defmodule TobaccosClubWeb.BlendsLive.IndexTest do
  use TobaccosClubWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Buscar por mistura ou marca"
    assert render(page_live) =~ "mistura"
  end
end
