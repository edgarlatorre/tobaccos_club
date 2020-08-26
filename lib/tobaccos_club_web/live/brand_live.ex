defmodule TobaccosClubWeb.BrandLive do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Tobaccos

  @impl true
  def mount(%{"slug" => slug}, _session, socket) do
    {:ok, assign(socket, brand: Tobaccos.get_brand_by_slug(slug))}
  end
end
