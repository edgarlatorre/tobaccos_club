defmodule TobaccosClub.Utils.CountryTest do
  use TobaccosClub.DataCase
  alias TobaccosClub.Utils.Country

  describe "Country" do
    test "list countries" do
      assert 24 == Enum.count(Country.list_countries())
    end
  end
end
