defmodule TobaccosClub.Pipes.FilterTest do
  use TobaccosClub.DataCase
  alias TobaccosClub.Pipes.Filter

  describe "Filter" do
    test "build empty filter" do
      assert %{starts_with: "", search_text: "", blend_type_ids: [], countries: [], cut_ids: []} =
               Filter.build()
    end
  end

  describe "filter_by_name" do
    @filter %Filter{
      starts_with: "A",
      search_text: "peterson",
      blend_type_ids: [1, 2],
      countries: ["BR"],
      cut_ids: [3, 4]
    }

    test "cut_ids" do
      assert [3, 4] == Filter.filter_by_name(@filter, "cut_ids")
    end

    test "blend_type_ids" do
      assert [1, 2] == Filter.filter_by_name(@filter, "blend_type_ids")
    end

    test "countries" do
      assert ["BR"] == Filter.filter_by_name(@filter, "countries")
    end

    test "search_text" do
      assert "peterson" == Filter.filter_by_name(@filter, "search_text")
    end

    test "starts_with" do
      assert "A" == Filter.filter_by_name(@filter, "starts_with")
    end
  end
end
