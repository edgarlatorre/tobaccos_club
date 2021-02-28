defmodule TobaccosClubWeb.SitemapView do
  use TobaccosClubWeb, :view
  @tobaccos_domain "https://www.tabacos.club"

  # Temporary solution until fix the raw domain
  def url_for(blend) do
    "#{@tobaccos_domain}/#{URI.encode_www_form(blend.brand.slug)}/#{
      URI.encode_www_form(blend.slug)
    }"
  end
end
