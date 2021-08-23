defmodule TobaccosClubWeb.Schema.Query.ListBlendsTest do
  use TobaccosClubWeb.ConnCase, async: true
  import TobaccosClub.TobaccosFactory

  @query """
  {
    blends {
      name
      slug
      manufactured_by
      flavouring
      packaging
      production
      contents
      image_url
      blend_type {
        name
      }
      brand {
        name
      }
      cut {
        name
      }
      country {
        name
      }
    }
  }
  """
  test "blends field returns tobacco blends" do
    cut = insert(:cut, name: "Ribbon")

    insert(:blend,
      name: "Early Morning Pipe",
      slug: "early-morning-pipe",
      manufactured_by: "Scandinavian Tobacco Group",
      flavouring: "None",
      contents: "Latakia, Oriental/Turkish, Virginia",
      image_url: "https://images.tabacos.club/early-morning-pipe.png",
      blend_type: insert(:blend_type, name: "English"),
      brand: insert(:brand, name: "Peterson"),
      cut: cut,
      country: insert(:country, name: "DK")
    )

    insert(:blend,
      name: "Belmont Station",
      slug: "belmont-station",
      manufactured_by: "Cornell & Diehl",
      flavouring: "Rum, Vanilla",
      contents: "Black Cavendish, Burley, Kentucky, Virginia",
      image_url: "https://images.tabacos.club/belmont-station.png",
      blend_type: insert(:blend_type, name: "Aromatic"),
      brand: insert(:brand, name: "Cornell & Diehl"),
      cut: cut,
      country: insert(:country, name: "US")
    )

    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert json_response(conn, 200) == %{
             "data" => %{
               "blends" => [
                 %{
                   "name" => "Early Morning Pipe",
                   "slug" => "early-morning-pipe",
                   "manufactured_by" => "Scandinavian Tobacco Group",
                   "flavouring" => "None",
                   "packaging" => "50 grams tin, bulk",
                   "production" => "Currently available",
                   "contents" => "Latakia, Oriental/Turkish, Virginia",
                   "image_url" => "https://images.tabacos.club/early-morning-pipe.png",
                   "blend_type" => %{
                     "name" => "English"
                   },
                   "brand" => %{
                     "name" => "Peterson"
                   },
                   "cut" => %{
                     "name" => "Ribbon"
                   },
                   "country" => %{
                     "name" => "DK"
                   }
                 },
                 %{
                   "name" => "Belmont Station",
                   "slug" => "belmont-station",
                   "manufactured_by" => "Cornell & Diehl",
                   "flavouring" => "Rum, Vanilla",
                   "packaging" => "50 grams tin, bulk",
                   "production" => "Currently available",
                   "contents" => "Black Cavendish, Burley, Kentucky, Virginia",
                   "image_url" => "https://images.tabacos.club/belmont-station.png",
                   "blend_type" => %{
                     "name" => "Aromatic"
                   },
                   "brand" => %{
                     "name" => "Cornell & Diehl"
                   },
                   "cut" => %{
                     "name" => "Ribbon"
                   },
                   "country" => %{
                     "name" => "US"
                   }
                 }
               ]
             }
           }
  end
end
