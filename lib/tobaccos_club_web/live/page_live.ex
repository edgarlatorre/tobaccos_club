defmodule TobaccosClubWeb.PageLive do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Reviewer
  alias TobaccosClubWeb.PageLive
  alias TobaccosClubWeb.Router.Helpers

  @impl true
  def mount(_params, _session, socket) do
    %{
      entries: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    } =
      if connected?(socket) do
        Reviewer.paginate_brands()
      else
        %Scrivener.Page{}
      end

    alphabet = for n <- ?a..?z, do: String.capitalize(<<n::utf8>>)

    assigns = [
      conn: socket,
      brands: entries,
      page_number: page_number || 0,
      page_size: page_size || 0,
      total_entries: total_entries || 0,
      total_pages: total_pages || 0,
      alphabet: alphabet
    ]

    {:ok, assign(socket, assigns)}
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

  def handle_event("nav", %{"page" => page}, socket) do
    # IO.inspect(live_redirect(to: Helpers.live_path(socket, PageLive, page: page)))
    {:noreply, live_patch(to: Helpers.live_path(socket, PageLive, page: page))}
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

  def get_and_assign_page(page_number) do
    %{
      entries: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    } = Reviewer.paginate_brands(page: page_number)

    alphabet = for n <- ?a..?z, do: String.capitalize(<<n::utf8>>)

    [
      brands: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages,
      alphabet: alphabet
    ]
  end
end
