defmodule TobaccosClub.PipesTest do
  use TobaccosClub.DataCase

  alias TobaccosClub.Pipes

  describe "cuts" do
    alias TobaccosClub.Pipes.Cut

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def cut_fixture(attrs \\ %{}) do
      {:ok, cut} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pipes.create_cut()

      cut
    end

    test "list_cuts/0 returns all cuts" do
      cut = cut_fixture()
      assert Pipes.list_cuts() == [cut]
    end

    test "get_cut!/1 returns the cut with given id" do
      cut = cut_fixture()
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
      cut = cut_fixture()
      assert {:ok, %Cut{} = cut} = Pipes.update_cut(cut, @update_attrs)
      assert cut.name == "some updated name"
    end

    test "update_cut/2 with invalid data returns error changeset" do
      cut = cut_fixture()
      assert {:error, %Ecto.Changeset{}} = Pipes.update_cut(cut, @invalid_attrs)
      assert cut == Pipes.get_cut!(cut.id)
    end

    test "delete_cut/1 deletes the cut" do
      cut = cut_fixture()
      assert {:ok, %Cut{}} = Pipes.delete_cut(cut)
      assert_raise Ecto.NoResultsError, fn -> Pipes.get_cut!(cut.id) end
    end

    test "change_cut/1 returns a cut changeset" do
      cut = cut_fixture()
      assert %Ecto.Changeset{} = Pipes.change_cut(cut)
    end
  end
end
