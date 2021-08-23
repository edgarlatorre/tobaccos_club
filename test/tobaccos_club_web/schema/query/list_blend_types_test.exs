defmodule TobaccosClubWeb.Schema.Query.ListBlendTypesTest do
  use TobaccosClubWeb.ConnCase, async: true
  import TobaccosClub.TobaccosFactory

  @query """
  {
    blend_types {
      name
    }
  }
  """
  test "cuts field returns tobacco blend types" do
    insert(:blend_type, name: "Virginia")
    insert(:blend_type, name: "Aromatic")

    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert json_response(conn, 200) == %{
             "data" => %{
               "blend_types" => [
                 %{"name" => "Virginia"},
                 %{"name" => "Aromatic"}
               ]
             }
           }
  end
end
