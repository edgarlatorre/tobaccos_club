defmodule TobaccosClub.PipesTest do
  use TobaccosClub.DataCase

  alias TobaccosClub.Pipes
  import TobaccosClub.TobaccosFactory

  describe "cuts" do
    alias TobaccosClub.Pipes.Cut

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    test "list_cuts/0 returns all cuts" do
      cut = insert(:cut)
      assert Pipes.list_cuts() == [cut]
    end

    test "get_cut!/1 returns the cut with given id" do
      cut = insert(:cut)
      assert Pipes.get_cut!(cut.id) == cut
    end

    test "create_cut/1 with valid data creates a cut" do
      assert {:ok, %Cut{} = cut} = Pipes.create_cut(@valid_attrs)
      assert cut.name == "some name"
    end

    test "create_cut/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pipes.create_cut(@invalid_attrs)
    end

    test "update_cut/2 with valid data updates the cut" do
      cut = insert(:cut)
      assert {:ok, %Cut{} = cut} = Pipes.update_cut(cut, @update_attrs)
      assert cut.name == "some updated name"
    end

    test "update_cut/2 with invalid data returns error changeset" do
      cut = insert(:cut)
      assert {:error, %Ecto.Changeset{}} = Pipes.update_cut(cut, @invalid_attrs)
      assert cut == Pipes.get_cut!(cut.id)
    end

    test "delete_cut/1 deletes the cut" do
      cut = insert(:cut)
      assert {:ok, %Cut{}} = Pipes.delete_cut(cut)
      assert_raise Ecto.NoResultsError, fn -> Pipes.get_cut!(cut.id) end
    end

    test "change_cut/1 returns a cut changeset" do
      cut = insert(:cut)
      assert %Ecto.Changeset{} = Pipes.change_cut(cut)
    end

    test "get_cut_by_name/1 returns a cut" do
      insert(:cut, name: "Flake")
      assert %Pipes.Cut{} = Pipes.get_cut_by_name("Flake")
    end
  end

  describe "countries" do
    alias TobaccosClub.Pipes.Country

    @valid_attrs %{locale: "some locale", name: "some name"}
    @update_attrs %{locale: "some updated locale", name: "some updated name"}
    @invalid_attrs %{locale: nil, name: nil}

    def country_fixture(attrs \\ %{}) do
      {:ok, country} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pipes.create_country()

      country
    end

    test "list_countries/0 returns all countries" do
      country = country_fixture()
      assert Pipes.list_countries() == [country]
    end

    test "get_country!/1 returns the country with given id" do
      country = country_fixture()
      assert Pipes.get_country!(country.id) == country
    end

    test "create_country/1 with valid data creates a country" do
      assert {:ok, %Country{} = country} = Pipes.create_country(@valid_attrs)
      assert country.locale == "some locale"
      assert country.name == "some name"
    end

    test "create_country/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pipes.create_country(@invalid_attrs)
    end

    test "update_country/2 with valid data updates the country" do
      country = country_fixture()
      assert {:ok, %Country{} = country} = Pipes.update_country(country, @update_attrs)
      assert country.locale == "some updated locale"
      assert country.name == "some updated name"
    end

    test "update_country/2 with invalid data returns error changeset" do
      country = country_fixture()
      assert {:error, %Ecto.Changeset{}} = Pipes.update_country(country, @invalid_attrs)
      assert country == Pipes.get_country!(country.id)
    end

    test "delete_country/1 deletes the country" do
      country = country_fixture()
      assert {:ok, %Country{}} = Pipes.delete_country(country)
      assert_raise Ecto.NoResultsError, fn -> Pipes.get_country!(country.id) end
    end

    test "change_country/1 returns a country changeset" do
      country = country_fixture()
      assert %Ecto.Changeset{} = Pipes.change_country(country)
    end
  end
end
