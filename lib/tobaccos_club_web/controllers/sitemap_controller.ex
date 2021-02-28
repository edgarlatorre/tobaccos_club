defmodule TobaccosClubWeb.SitemapController do
  use TobaccosClubWeb, :controller
  alias TobaccosClub.Services.Storage

  def index(conn, _params) do
    sitemap_file = Application.get_env(:tobaccos_club, :sitemap_file)

    conn
    |> put_resp_content_type("text/xml")
    |> text(Storage.get_file_content(sitemap_file))
  end
end
