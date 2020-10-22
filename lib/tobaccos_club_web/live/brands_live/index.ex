defmodule TobaccosClubWeb.BrandsLive.Index do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Reviewer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, brands: Reviewer.list_brands())}
  end
end
