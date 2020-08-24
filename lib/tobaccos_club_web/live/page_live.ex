defmodule TobaccosClubWeb.PageLive do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Tobaccos

  @impl true
  def mount(_params, _session, socket) do
    alphabet = for n <- ?a..?z, do: String.capitalize(<<n::utf8>>)
    {:ok, assign(socket, brands: Tobaccos.list_brands(), alphabet: alphabet)}
  end

  @impl true
  def handle_event("filter", %{"letter" => letter}, socket) do
    brands = Tobaccos.list_brands_starting_with(letter)
    {:noreply, assign(socket, brands: brands)}
  end

  @impl true
  def handle_event("search", %{"brand" => brand_name}, socket) do
    brands = Tobaccos.find_brands_by_name(brand_name)
    {:noreply, assign(socket, brands: brands)}
  end
end
