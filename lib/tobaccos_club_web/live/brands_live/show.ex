defmodule TobaccosClubWeb.BrandsLive.Show do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Reviewer

  @impl true
  def mount(%{"brand_slug" => slug}, _session, socket) do
    {:ok, assign(socket, brand: Reviewer.get_brand_by_slug(slug))}
  end
end
