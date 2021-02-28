defmodule TobaccosClub.Services.SitemapGenerator do
  def generate(blends_info) do
    Phoenix.View.render_to_string(TobaccosClubWeb.SitemapView, "index.xml", %{blends: blends_info})
  end
end
