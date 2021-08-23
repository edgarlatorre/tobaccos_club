defmodule TobaccosClubWeb.Schema.Query.ListCutsTest do
  use TobaccosClubWeb.ConnCase, async: true
  import TobaccosClub.TobaccosFactory

  @query """
  {
    cuts {
      name
    }
  }
  """
  test "cuts field returns tobacco cuts" do
    insert(:cut, name: "Flake")
    insert(:cut, name: "Ribbon")

    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert json_response(conn, 200) == %{
             "data" => %{
               "cuts" => [
                 %{"name" => "Flake"},
                 %{"name" => "Ribbon"}
               ]
             }
           }
  end
end
