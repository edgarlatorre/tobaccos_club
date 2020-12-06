defmodule TobaccosClubWeb.BlendsLive.Index do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Pagination.Info
  alias TobaccosClub.Pipes
  alias TobaccosClub.Pipes.Filter
  alias TobaccosClub.Reviewer
  alias TobaccosClub.Utils.Country

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
      blend_types: Reviewer.list_blend_types(),
      countries: Country.list_localized_countries(),
      cuts: Pipes.list_cuts(),
      pagination_info: %Info{
        page_number: page_number || 0,
        page_size: page_size || 100,
        total_entries: total_entries || 0,
        total_pages: total_pages || 0
      },
      alphabet: alphabet,
      filter: %Filter{
        starts_with: "",
        search_text: "",
        blend_type_ids: [],
        countries: [],
        cut_ids: []
      }
    ]

    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_params(%{"page" => page}, _, socket) do
    %{filter: filter} = socket.assigns
    assigns = get_and_assign_page(filter, page)

    {:noreply, assign(socket, assigns)}
  end

  def handle_params(_, _, socket) do
    %{filter: filter} = socket.assigns
    assigns = get_and_assign_page(filter, nil)

    {:noreply, assign(socket, assigns)}
  end

  @impl true
  def handle_event("search", %{"brand" => brand_name}, socket) do
    filter = %Filter{socket.assigns.filter | search_text: brand_name}
    assigns = get_and_assign_page(filter, nil)

    {:noreply, assign(socket, assigns)}
  end

  @impl true
  def handle_event("filter", %{"blend_type_ids" => blend_type_ids}, socket) do
    filter = %Filter{socket.assigns.filter | blend_type_ids: blend_type_ids}
    assigns = get_and_assign_page(filter, nil)

    {:noreply, assign(socket, assigns)}
  end

  @impl true
  def handle_event("filter", %{"countries" => countries}, socket) do
    filter = %Filter{socket.assigns.filter | countries: countries}
    assigns = get_and_assign_page(filter, nil)

    {:noreply, assign(socket, assigns)}
  end

  @impl true
  def handle_event("filter", %{"cut_ids" => cut_ids}, socket) do
    filter = %Filter{socket.assigns.filter | cut_ids: cut_ids}
    assigns = get_and_assign_page(filter, nil)

    {:noreply, assign(socket, assigns)}
  end

  def get_and_assign_page(filter, page_number) do
    criteria = [
      starts_with: filter.starts_with,
      search_text: filter.search_text,
      blend_type_ids: filter.blend_type_ids,
      countries: filter.countries,
      cut_ids: filter.cut_ids
    ]

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
      pagination_info: %Info{
        page_number: page_number,
        page_size: page_size,
        total_entries: total_entries,
        total_pages: total_pages
      },
      alphabet: alphabet,
      filter: filter,
      selected_filters: selected_filters(filter)
    ]
  end

  defp pagination_params(params) do
    %{
      page: Map.get(params, "page", 1),
      page_size: Map.get(params, "page_size", 100)
    }
  end

  defp selected_filters(filter) do
    filter.blend_type_ids ++ filter.countries ++ filter.cut_ids
  end
end
