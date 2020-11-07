defmodule TobaccosClub.Services.PopulateTest do
  use TobaccosClub.DataCase
  alias TobaccosClub.Pipes
  alias TobaccosClub.Reviewer
  alias TobaccosClub.Services.Populate

  describe "populate brands" do
    test "create brands with slug" do
      Populate.brands([
        %{"name" => "Brand One", "url" => "http://test.com/brand-one"},
        %{"name" => "Brand Two", "url" => "http://test.com/brand-two"}
      ])

      assert 2 == Enum.count(Reviewer.list_brands())
      assert "Brand One" = Reviewer.get_brand_by_slug("brand-one").name
      assert "Brand Two" = Reviewer.get_brand_by_slug("brand-two").name
    end
  end

  describe "populate blend_types" do
    test "create blend_types" do
      Populate.blend_types([
        %{"blend_type" => "Aromatic"},
        %{"blend_type" => "Virginia/Perique"}
      ])

      assert 2 == Enum.count(Reviewer.list_blend_types())
      assert %Pipes.BlendType{} = Reviewer.get_blend_type_by_name("Aromatic")
      assert %Pipes.BlendType{} = Reviewer.get_blend_type_by_name("Virginia/Perique")
    end

    test "populate blends" do
      Reviewer.create_blend_type(%{name: "Virginia"})
      Reviewer.create_brand(%{name: "Brand", slug: "blend", url: "http://test.com"})
      Pipes.create_cut(%{name: "Ribbon"})

      Populate.blends([
        %{
          "blended_by" => "some blended_by",
          "blend_type" => "Virginia",
          "brand" => "Brand",
          "contents" => "some contents",
          "country" => "some country",
          "cut" => "Ribbon",
          "flavouring" => "some flavouring",
          "image_url" => "some image_url",
          "manufactured_by" => "some manufactured_by",
          "name" => "some name",
          "packaging" => "some packaging",
          "production" => "some production"
        }
      ])

      assert Enum.count(Reviewer.list_blends()) == 1
    end
  end

  describe "populate cuts" do
    test "create cuts" do
      Populate.cuts([
        %{"name" => "Ribbon"},
        %{"name" => "Flake"}
      ])

      assert 2 == Enum.count(Pipes.list_cuts())
      assert %Pipes.Cut{} = Pipes.get_cut_by_name("Ribbon")
      assert %Pipes.Cut{} = Pipes.get_cut_by_name("Flake")
    end
  end
end
