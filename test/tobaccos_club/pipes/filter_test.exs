defmodule TobaccosClub.Pipes.FilterTest do
  use TobaccosClub.DataCase
  alias TobaccosClub.Pipes.Filter

  describe "Filter" do
    test "build empty filter" do
      assert %{starts_with: "", search_text: "", blend_type_ids: [], countries: []} =
               Filter.build()
    end
  end
end
