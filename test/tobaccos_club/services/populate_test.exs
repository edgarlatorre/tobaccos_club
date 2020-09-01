defmodule TobaccosClub.Services.PopulateTest do
  use TobaccosClub.DataCase
  alias TobaccosClub.Services.Populate
  alias TobaccosClub.Tobaccos

  describe "populate brands" do
    test "create brands with slug" do
      Populate.brands([
        %{"name" => "Brand One", "url" => "http://test.com/brand-one"},
        %{"name" => "Brand Two", "url" => "http://test.com/brand-two"}
      ])

      assert 2 == Enum.count(Tobaccos.list_brands())
      assert "Brand One" = Tobaccos.get_brand_by_slug("brand-one").name
      assert "Brand Two" = Tobaccos.get_brand_by_slug("brand-two").name
    end
  end

  describe "populate blend_types" do
    test "create blend_types" do
      Populate.blend_types([
        %{"blend_type" => "Aromatic"},
        %{"blend_type" => "Virginia/Perique"}
      ])

      assert 2 == Enum.count(Tobaccos.list_blend_types())
      assert %Tobaccos.BlendType{} = Tobaccos.get_blend_type_by_name("Aromatic")
      assert %Tobaccos.BlendType{} = Tobaccos.get_blend_type_by_name("Virginia/Perique")
    end

    test "populate blends" do
      Tobaccos.create_blend_type(%{name: "Virginia"})
      Tobaccos.create_brand(%{name: "Brand", slug: "blend", url: "http://test.com"})

      Populate.blends([
        %{
          "blended_by" => "some blended_by",
          "blend_type" => "Virginia",
          "brand" => "Brand",
          "contents" => "some contents",
          "country" => "some country",
          "cut" => "some cut",
          "flavouring" => "some flavouring",
          "image_url" => "some image_url",
          "manufactured_by" => "some manufactured_by",
          "name" => "some name",
          "packaging" => "some packaging",
          "production" => "some production"
        }
      ])

      assert Enum.count(Tobaccos.list_blends()) == 1
    end
  end
end
