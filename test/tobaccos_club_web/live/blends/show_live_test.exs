defmodule TobaccosClubWeb.Blends.ShowLiveTest do
  use TobaccosClubWeb.ConnCase

  import Phoenix.LiveViewTest
  import TobaccosClub.TobaccosFactory

  test "disconnected and connected render", %{conn: conn} do
    blend_type = insert(:blend_type, name: "English")
    blend = insert(:blend, name: "My Mixture 965", blend_type: blend_type)

    {:ok, page_live, disconnected_html} = live(conn, "/peterson/#{blend.id}")
    assert disconnected_html =~ "My Mixture 965"
    assert render(page_live) =~ "English"
  end
end
