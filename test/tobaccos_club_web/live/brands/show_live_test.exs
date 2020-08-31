defmodule TobaccosClubWeb.Brands.ShowLiveTest do
  alias TobaccosClub.Tobaccos
  use TobaccosClubWeb.ConnCase

  import Phoenix.LiveViewTest

  @valid_attrs %{name: "Blend Test", slug: "blend-test", url: "some url"}

  def brand_fixture(attrs \\ %{}) do
    {:ok, brand} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Tobaccos.create_brand()

    brand
  end

  test "disconnected and connected render", %{conn: conn} do
    brand_fixture()
    {:ok, page_live, disconnected_html} = live(conn, "/blend-test")
    assert disconnected_html =~ "Blend Test"
    assert render(page_live) =~ "Blends"
  end
end
