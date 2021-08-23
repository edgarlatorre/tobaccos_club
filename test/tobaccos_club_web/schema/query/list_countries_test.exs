defmodule TobaccosClubWeb.Schema.Query.ListCountriesTest do
  use TobaccosClubWeb.ConnCase, async: true
  import TobaccosClub.TobaccosFactory

  @query """
  {
    countries {
      name
    }
  }
  """
  test "countries field returns countries" do
    insert(:country, name: "Brazil")
    insert(:country, name: "United States")

    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert json_response(conn, 200) == %{
             "data" => %{
               "countries" => [
                 %{"name" => "Brazil"},
                 %{"name" => "United States"}
               ]
             }
           }
  end
end
