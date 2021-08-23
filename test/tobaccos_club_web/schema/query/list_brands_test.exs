defmodule TobaccosClubWeb.Schema.Query.ListBrandsTest do
  use TobaccosClubWeb.ConnCase, async: true
  import TobaccosClub.TobaccosFactory

  @query """
  {
    brands {
      name
    }
  }
  """
  test "cuts field returns tobacco brands" do
    insert(:brand, name: "Peterson")
    insert(:brand, name: "C & D")

    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert json_response(conn, 200) == %{
             "data" => %{
               "brands" => [
                 %{"name" => "C & D"},
                 %{"name" => "Peterson"}
               ]
             }
           }
  end
end
