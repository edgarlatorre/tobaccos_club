defmodule TobaccosClubWeb.BrandsLive.Index do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Pagination.Info
  alias TobaccosClub.Reviewer

  @impl true
  def mount(params, _session, socket) do
    %{
      entries: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    } =
      if connected?(socket) do
        Reviewer.paginate_brands(pagination_params(params))
      else
        %Scrivener.Page{}
      end

    assigns = [
      conn: socket,
      brands: entries,
      pagination_info: %Info{
        page_number: page_number || 0,
        page_size: page_size || 100,
        total_entries: total_entries || 0,
        total_pages: total_pages || 0
      }
    ]

    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_params(%{"page" => page}, _, socket) do
    assigns = get_and_assign_page(page)

    {:noreply, assign(socket, assigns)}
  end

  def handle_params(_, _, socket), do: {:noreply, assign(socket, get_and_assign_page(1))}

  defp get_and_assign_page(page_number) do
    %{
      entries: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    } = Reviewer.paginate_brands(%{page: page_number})

    [
      brands: entries,
      pagination_info: %Info{
        page_number: page_number,
        page_size: page_size,
        total_entries: total_entries,
        total_pages: total_pages
      }
    ]
  end

  defp pagination_params(params) do
    %{
      page: Map.get(params, "page", 1),
      page_size: Map.get(params, "page_size", 100)
    }
  end
end
