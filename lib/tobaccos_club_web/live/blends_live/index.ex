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
      alphabet: alphabet,
      starts_with: "",
      search_text: ""
    ]

    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_params(%{"page" => page}, _, socket) do
    %{starts_with: starts_with, search_text: search_text} = socket.assigns
    assigns = get_and_assign_page(starts_with, search_text, page)

    {:noreply, assign(socket, assigns)}
  end

  def handle_params(_, _, socket) do
    %{starts_with: starts_with, search_text: search_text} = socket.assigns
    assigns = get_and_assign_page(starts_with, search_text, nil)

    {:noreply, assign(socket, assigns)}
  end

  @impl true
  def handle_event("filter", %{"letter" => letter}, socket) do
    %{search_text: search_text} = socket.assigns
    assigns = get_and_assign_page(letter, search_text, nil)
    {:noreply, assign(socket, assigns)}
  end

  @impl true
  def handle_event("search", %{"brand" => brand_name}, socket) do
    %{starts_with: starts_with} = socket.assigns
    assigns = get_and_assign_page(starts_with, brand_name, nil)

    {:noreply, assign(socket, assigns)}
  end

  def get_and_assign_page(starts_with, search_text, page_number) do
    criteria = [starts_with: starts_with, search_text: search_text]

    %{
      entries: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    } = Reviewer.paginate_blends(criteria, %{page: page_number})

    alphabet = for n <- ?a..?z, do: String.capitalize(<<n::utf8>>)

    [
      blends: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages,
      alphabet: alphabet,
      starts_with: starts_with,
      search_text: search_text
    ]
  end

  defp pagination_params(params) do
    %{
      page: Map.get(params, "page", 1),
      page_size: Map.get(params, "page_size", 10)
    }
  end
end
