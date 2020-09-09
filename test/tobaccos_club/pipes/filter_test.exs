defmodule TobaccosClub.Pipes.FilterTest do
  use TobaccosClub.DataCase
  alias TobaccosClub.Pipes.Filter

  describe "Filter" do
    test "build empty filter" do
      assert %{starts_with: "", search_text: "", blend_type_ids: []} = Filter.build()
    end

    # test "build empty filter with starts_with A" do
    #   assert %{starts_with: "A", search_text: "",  blend_type_ids: []} = Filter.build(starts_with: "A")
    # end

    # test "build empty filter with search_text test" do
    #   assert %{starts_with: "", search_text: "test",  blend_type_ids: []} = Filter.build(search_text: "test")
    # end
  end
end
