defmodule TobaccosClubWeb.Brands.ShowLiveTest do
  use TobaccosClubWeb.ConnCase

  import Phoenix.LiveViewTest
  import TobaccosClub.TobaccosFactory

  test "disconnected and connected render", %{conn: conn} do
    insert(:brand, name: "Blend Test", slug: "blend-test")

    {:ok, page_live, disconnected_html} = live(conn, "/blend-test")
    assert disconnected_html =~ "Blend Test"
    assert render(page_live) =~ "Blends"
  end
end
