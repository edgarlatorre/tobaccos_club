defmodule TobaccosClubWeb.BlendsLive.Index do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Reviewer

  @impl true
  def mount(params, _session, socket) do
    alphabet = for n <- ?a..?z, do: String.capitalize(<<n::utf8>>)

    %{
      entries: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    } =
      if connected?(socket) do
        Reviewer.paginate_blends(pagination_params(params))
      else
        %Scrivener.Page{}
      end

    assigns = [
      conn: socket,
      blends: entries,
      page_number: page_number || 0,
      page_size: page_size || 0,
      total_entries: total_entries || 0,
      total_pages: total_pages || 0,
      alphabet: alphabet
    ]

    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_params(%{"page" => page}, _, socket) do
    assigns = get_and_assign_page(page)
    {:noreply, assign(socket, assigns)}
  end

  def handle_params(_, _, socket) do
    assigns = get_and_assign_page(nil)
    {:noreply, assign(socket, assigns)}
  end

  @impl true
  def handle_event("filter", %{"letter" => letter}, socket) do
    blends = Reviewer.paginate_blends_starting_with(letter)
    {:noreply, assign(socket, blends: blends)}
  end

  @impl true
  def handle_event("search", %{"brand" => brand_name}, socket) do
    blends = Reviewer.paginate_blends_name_includes(brand_name)
    {:noreply, assign(socket, blends: blends)}
  end

  def get_and_assign_page(page_number) do
    %{
      entries: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    } = Reviewer.paginate_blends(%{page: page_number})

    alphabet = for n <- ?a..?z, do: String.capitalize(<<n::utf8>>)

    [
      blends: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages,
      alphabet: alphabet
    ]
  end

  defp pagination_params(params) do
    %{
      page: Map.get(params, "page", 1),
      page_size: Map.get(params, "page_size", 10)
    }
  end
end
