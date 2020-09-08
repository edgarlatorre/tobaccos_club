defmodule TobaccosClub.PipesTest do
  use TobaccosClub.DataCase

  alias TobaccosClub.Reviewer
  import TobaccosClub.TobaccosFactory

  describe "brands" do
    alias TobaccosClub.Pipes.Brand

    @valid_attrs %{name: "Blend Test", slug: "blend-test", url: "some url"}
    @update_attrs %{name: "some updated name", slug: "some updated slug", url: "some updated url"}
    @invalid_attrs %{name: nil, slug: nil, url: nil}

    test "list_brands/0 returns all brands" do
      brand = insert(:brand)
      assert Reviewer.list_brands() == [brand]
    end

    test "get_brand!/1 returns the brand with given id" do
      brand = insert(:brand)
      assert Reviewer.get_brand!(brand.id) == brand
    end

    test "create_brand/1 with valid data creates a brand" do
      assert {:ok, %Brand{} = brand} = Reviewer.create_brand(@valid_attrs)
      assert brand.name == "Blend Test"
      assert brand.slug == "blend-test"
      assert brand.url == "some url"
    end

    test "create_brand/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reviewer.create_brand(@invalid_attrs)
    end

    test "update_brand/2 with valid data updates the brand" do
      brand = insert(:brand)
      assert {:ok, %Brand{} = brand} = Reviewer.update_brand(brand, @update_attrs)
      assert brand.name == "some updated name"
      assert brand.slug == "some updated slug"
      assert brand.url == "some updated url"
    end

    test "update_brand/2 with invalid data returns error changeset" do
      brand = insert(:brand)
      assert {:error, %Ecto.Changeset{}} = Reviewer.update_brand(brand, @invalid_attrs)
      assert brand == Reviewer.get_brand!(brand.id)
    end

    test "delete_brand/1 deletes the brand" do
      brand = insert(:brand)
      assert {:ok, %Brand{}} = Reviewer.delete_brand(brand)
      assert_raise Ecto.NoResultsError, fn -> Reviewer.get_brand!(brand.id) end
    end

    test "change_brand/1 returns a brand changeset" do
      brand = insert(:brand)
      assert %Ecto.Changeset{} = Reviewer.change_brand(brand)
    end

    test "list_brands_starting_with/1 returns brands starting with B" do
      brand = insert(:brand)
      assert Reviewer.list_brands_starting_with("B") == [brand]
      assert Reviewer.list_brands_starting_with("b") == [brand]
    end

    test "list_brands_starting_with/1 returns empty list" do
      insert(:brand)
      assert Reviewer.list_brands_starting_with("t") == []
    end

    test "list_brands_starting_with/1 returns all" do
      brand = insert(:brand)
      assert Reviewer.list_brands_starting_with("all") == [brand]
    end

    test "get_brand_by_slug/1 returns a brand changeset" do
      brand = insert(:brand, slug: "blend-test")
      assert Reviewer.get_brand_by_slug("blend-test").id == brand.id
    end

    test "find_brands_name_includes/1 returns brands that name contains Test" do
      brand = insert(:brand, name: "test")
      assert Reviewer.find_brands_name_includes("test") == [brand]
    end
  end

  describe "blend_types" do
    alias TobaccosClub.Pipes.BlendType

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    test "list_blend_types/0 returns all blend_types" do
      blend_type = insert(:blend_type)
      assert Reviewer.list_blend_types() == [blend_type]
    end

    test "get_blend_type!/1 returns the blend_type with given id" do
      blend_type = insert(:blend_type)
      assert Reviewer.get_blend_type!(blend_type.id) == blend_type
    end

    test "create_blend_type/1 with valid data creates a blend_type" do
      assert {:ok, %BlendType{} = blend_type} = Reviewer.create_blend_type(@valid_attrs)
      assert blend_type.name == "some name"
    end

    test "create_blend_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reviewer.create_blend_type(@invalid_attrs)
    end

    test "update_blend_type/2 with valid data updates the blend_type" do
      blend_type = insert(:blend_type)

      assert {:ok, %BlendType{} = blend_type} =
               Reviewer.update_blend_type(blend_type, @update_attrs)

      assert blend_type.name == "some updated name"
    end

    test "update_blend_type/2 with invalid data returns error changeset" do
      blend_type = insert(:blend_type)
      assert {:error, %Ecto.Changeset{}} = Reviewer.update_blend_type(blend_type, @invalid_attrs)
      assert blend_type == Reviewer.get_blend_type!(blend_type.id)
    end

    test "delete_blend_type/1 deletes the blend_type" do
      blend_type = insert(:blend_type)
      assert {:ok, %BlendType{}} = Reviewer.delete_blend_type(blend_type)
      assert_raise Ecto.NoResultsError, fn -> Reviewer.get_blend_type!(blend_type.id) end
    end

    test "change_blend_type/1 returns a blend_type changeset" do
      blend_type = insert(:blend_type)
      assert %Ecto.Changeset{} = Reviewer.change_blend_type(blend_type)
    end
  end

  describe "blends" do
    alias TobaccosClub.Pipes.Blend

    @valid_attrs %{
      blended_by: "some blended_by",
      contents: "some contents",
      country: "some country",
      cut: "some cut",
      flavouring: "some flavouring",
      image_url: "some image_url",
      manufactured_by: "some manufactured_by",
      name: "some name",
      packaging: "some packaging",
      production: "some production"
    }

    @update_attrs %{
      blended_by: "some updated blended_by",
      contents: "some updated contents",
      country: "some updated country",
      cut: "some updated cut",
      flavouring: "some updated flavouring",
      image_url: "some updated image_url",
      manufactured_by: "some updated manufactured_by",
      name: "some updated name",
      packaging: "some updated packaging",
      production: "some updated production"
    }

    test "list_blends/0 returns all blends" do
      insert(:blend, name: "blend test")
      assert [%Blend{name: "blend test"}] = Reviewer.list_blends()
    end

    test "paginate_blends/1 returns paginated blends with 2 entries per page" do
      insert_list(3, :brand)
      assert 2 == Reviewer.paginate_blends(%{page_size: 2, page: 1}).page_size
    end

    test "paginate_blends/1 returns paginated blends first page" do
      insert_list(3, :brand)
      assert 1 == Reviewer.paginate_blends(%{page_size: 2, page: 1}).page_number
    end

    test "paginate_blends/1 returns paginated blends second page" do
      insert_list(3, :brand)
      assert 2 == Reviewer.paginate_blends(%{page_size: 2, page: 2}).page_number
    end

    test "get_blend!/1 returns the blend with given id" do
      blend = insert(:blend)
      assert Reviewer.get_blend!(blend.id)
    end

    test "create_blend/1 with valid data creates a blend" do
      assert {:ok, %Blend{} = blend} = Reviewer.create_blend(@valid_attrs)
      assert blend.blended_by == "some blended_by"
      assert blend.contents == "some contents"
      assert blend.country == "some country"
      assert blend.cut == "some cut"
      assert blend.flavouring == "some flavouring"
      assert blend.image_url == "some image_url"
      assert blend.manufactured_by == "some manufactured_by"
      assert blend.name == "some name"
      assert blend.packaging == "some packaging"
      assert blend.production == "some production"
    end

    test "update_blend/2 with valid data updates the blend" do
      blend = insert(:blend)
      assert {:ok, %Blend{} = blend} = Reviewer.update_blend(blend, @update_attrs)
      assert blend.blended_by == "some updated blended_by"
      assert blend.contents == "some updated contents"
      assert blend.country == "some updated country"
      assert blend.cut == "some updated cut"
      assert blend.flavouring == "some updated flavouring"
      assert blend.image_url == "some updated image_url"
      assert blend.manufactured_by == "some updated manufactured_by"
      assert blend.name == "some updated name"
      assert blend.packaging == "some updated packaging"
      assert blend.production == "some updated production"
    end

    test "delete_blend/1 deletes the blend" do
      blend = insert(:blend)
      assert {:ok, %Blend{}} = Reviewer.delete_blend(blend)
      assert_raise Ecto.NoResultsError, fn -> Reviewer.get_blend!(blend.id) end
    end

    test "change_blend/1 returns a blend changeset" do
      blend = insert(:blend)
      assert %Ecto.Changeset{} = Reviewer.change_blend(blend)
    end
  end
end
