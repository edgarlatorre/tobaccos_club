defmodule TobaccosClubWeb.Blends.ShowLiveTest do
  alias TobaccosClub.Tobaccos
  use TobaccosClubWeb.ConnCase

  import Phoenix.LiveViewTest

  @brand_attrs %{name: "Peterson", slug: "peterson", url: "http://test.t/peterson"}

  @blend_attrs %{
    blended_by: "Dunhill",
    contents: "Cavendish, Latakia, Oriental/Turkish, Virginia",
    country: "UK",
    cut: "Ribbon",
    flavouring: "None",
    image_url: "",
    manufactured_by: "some manufactured_by",
    name: "My Mixture 965",
    packaging: "50 grams tin, bulk",
    production: "Currently available"
  }

  def brand_fixture(attrs \\ %{}) do
    {:ok, brand} =
      attrs
      |> Enum.into(@brand_attrs)
      |> Tobaccos.create_brand()

    brand
  end

  def blend_type_fixture(attrs \\ %{}) do
    {:ok, blend_type} = Tobaccos.create_blend_type(attrs)

    blend_type
  end

  def blend_fixture(attrs \\ %{}) do
    {:ok, blend} =
      attrs
      |> Enum.into(@blend_attrs)
      |> Tobaccos.create_blend()

    blend
  end

  test "disconnected and connected render", %{conn: conn} do
    brand = brand_fixture()
    blend_type = blend_type_fixture(%{name: "English"})
    blend = blend_fixture(%{blend_type_id: blend_type.id, brand_id: brand.id})

    {:ok, page_live, disconnected_html} = live(conn, "/peterson/#{blend.id}")
    assert disconnected_html =~ "My Mixture 965"
    assert render(page_live) =~ "English"
  end
end
