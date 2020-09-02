defmodule TobaccosClubWeb.PageLive do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Reviewer

  @impl true
  def mount(_params, _session, socket) do
    alphabet = for n <- ?a..?z, do: String.capitalize(<<n::utf8>>)
    {:ok, assign(socket, brands: Reviewer.list_brands(), alphabet: alphabet)}
  end

  @impl true
  def handle_event("filter", %{"letter" => letter}, socket) do
    brands = Reviewer.list_brands_starting_with(letter)
    {:noreply, assign(socket, brands: brands)}
  end

  @impl true
  def handle_event("search", %{"brand" => brand_name}, socket) do
    brands = Reviewer.find_brands_name_includes(brand_name)
    {:noreply, assign(socket, brands: brands)}
  end
end
