defmodule TobaccosClubWeb.PageLive do
  use TobaccosClubWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    alphabet = for n <- ?a..?z, do: String.capitalize(<<n::utf8>>)
    {:ok, assign(socket, brands: get_brands(), alphabet: alphabet)}
  end

  @impl true
  def handle_event("filter", %{"letter" => letter}, socket) do
    brands = Enum.filter(get_brands(), fn brand -> String.starts_with?(brand["name"], letter) end)

    {:noreply, assign(socket, brands: brands)}
  end

  @impl true
  def handle_event("search", %{"brand" => brand_name}, socket) do
    brands =
      Enum.filter(get_brands(), fn brand -> String.contains?(brand["name"], brand_name) end)

    {:noreply, assign(socket, brands: brands)}
  end

  defp get_brands do
    TobaccosClub.Tobaccos.Brand.all()
  end
end
