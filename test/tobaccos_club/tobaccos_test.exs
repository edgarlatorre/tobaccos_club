defmodule TobaccosClub.TobaccosTest do
  use TobaccosClub.DataCase
  alias TobaccosClub.Tobaccos

  describe "Brands" do
    test "list brands" do
      assert 613 == Enum.count(Tobaccos.list_brands())
    end

    test "list brands returns brand struct" do
      brand = List.first(Tobaccos.list_brands())
      assert %TobaccosClub.Tobaccos.Brand{} = brand
    end

    test "brands starting with A" do
      assert 27 == Enum.count(Tobaccos.list_brands_starting_with("A"))
    end

    test "filter search brands that name contains Pet" do
      assert 9 == Enum.count(Tobaccos.find_brands_by_name("Pet"))
    end
  end
end
