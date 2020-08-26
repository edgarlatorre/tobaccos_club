defmodule TobaccosClub.TobaccosTest do
  use TobaccosClub.DataCase
  alias TobaccosClub.Tobaccos

  describe "brands" do
    alias TobaccosClub.Tobaccos.Brand

    @valid_attrs %{name: "Blend Test", slug: "blend-test", url: "some url"}
    @update_attrs %{name: "some updated name", slug: "some updated slug", url: "some updated url"}
    @invalid_attrs %{name: nil, slug: nil, url: nil}

    def brand_fixture(attrs \\ %{}) do
      {:ok, brand} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tobaccos.create_brand()

      brand
    end

    test "list_brands/0 returns all brands" do
      brand = brand_fixture()
      assert Tobaccos.list_brands() == [brand]
    end

    test "get_brand!/1 returns the brand with given id" do
      brand = brand_fixture()
      assert Tobaccos.get_brand!(brand.id) == brand
    end

    test "create_brand/1 with valid data creates a brand" do
      assert {:ok, %Brand{} = brand} = Tobaccos.create_brand(@valid_attrs)
      assert brand.name == "Blend Test"
      assert brand.slug == "blend-test"
      assert brand.url == "some url"
    end

    test "create_brand/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tobaccos.create_brand(@invalid_attrs)
    end

    test "update_brand/2 with valid data updates the brand" do
      brand = brand_fixture()
      assert {:ok, %Brand{} = brand} = Tobaccos.update_brand(brand, @update_attrs)
      assert brand.name == "some updated name"
      assert brand.slug == "some updated slug"
      assert brand.url == "some updated url"
    end

    test "update_brand/2 with invalid data returns error changeset" do
      brand = brand_fixture()
      assert {:error, %Ecto.Changeset{}} = Tobaccos.update_brand(brand, @invalid_attrs)
      assert brand == Tobaccos.get_brand!(brand.id)
    end

    test "delete_brand/1 deletes the brand" do
      brand = brand_fixture()
      assert {:ok, %Brand{}} = Tobaccos.delete_brand(brand)
      assert_raise Ecto.NoResultsError, fn -> Tobaccos.get_brand!(brand.id) end
    end

    test "change_brand/1 returns a brand changeset" do
      brand = brand_fixture()
      assert %Ecto.Changeset{} = Tobaccos.change_brand(brand)
    end

    test "list_brands_starting_with/1 returns brands starting with B" do
      brand = brand_fixture()
      assert Tobaccos.list_brands_starting_with("B") == [brand]
      assert Tobaccos.list_brands_starting_with("b") == [brand]
    end

    test "list_brands_starting_with/1 returns empty list" do
      brand_fixture()
      assert Tobaccos.list_brands_starting_with("t") == []
    end

    test "get_brand_by_slug/1 returns a brand changeset" do
      brand = brand_fixture()
      assert Tobaccos.get_brand_by_slug("blend-test") == brand
    end

    test "find_brands_name_includes/1 returns brands that name contains Test" do
      brand = brand_fixture()
      assert Tobaccos.find_brands_name_includes("test") == [brand]
    end
  end
end
