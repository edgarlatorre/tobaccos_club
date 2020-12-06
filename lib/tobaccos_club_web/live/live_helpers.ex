defmodule TobaccosClubWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
  import TobaccosClubWeb.Gettext

  alias TobaccosClub.Pipes.Filter
  alias TobaccosClubWeb.Router.Helpers, as: Routes

  def value_or_dash(nil), do: "-"
  def value_or_dash(""), do: "-"
  def value_or_dash(value), do: value

  def render_pagination_navigation(socket, pagination_info, route) do
    assigns = %{socket: socket, pagination_info: pagination_info, route: route}

    ~L"""
    <div class="bg-white w-full py-3 flex items-center justify-between sm:px-6">
      <div class="flex-1 flex items-center justify-between">
        <div>
          <p class="text-sm leading-5 text-gray-700">
            <%= gettext "Showing" %>
            <span class="font-medium"><%= @pagination_info.page_number * @pagination_info.page_size - @pagination_info.page_size + 1 %></span>
            <%= gettext "to" %>
            <span class="font-medium"><%= @pagination_info.page_number * @pagination_info.page_size %></span>
            <%= gettext "of" %>
            <span class="font-medium"><%= @pagination_info.total_entries %></span>
            <%= gettext "results" %>
          </p>
        </div>
        <div>
          <nav class="relative z-0 inline-flex shadow-sm">
            <%= live_patch to: Routes.live_path(@socket, @route, page: @pagination_info.page_number - 1), class: "relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm leading-5 font-medium text-gray-500 hover:text-gray-400 focus:z-10 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:bg-gray-100 active:text-gray-500 transition ease-in-out duration-150" do %>
              <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
              </svg>
            <% end %>
            <%= live_patch to: Routes.live_path(@socket, @route, page: @pagination_info.page_number + 1), class: "relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm leading-5 font-medium text-gray-500 hover:text-gray-400 focus:z-10 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:bg-gray-100 active:text-gray-500 transition ease-in-out duration-150" do %>
              <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
              </svg>
            <% end %>
          </nav>
        </div>
      </div>
    </div>
    """
  end

  def render_filter_options(socket, elements, name, input_name, filter, value_name \\ "id") do
    assigns = %{socket: socket, filter: filter}

    ~L"""
    <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
      <div @click.away="open = false" class="relative border-2 border-gray-300 rounded-lg" x-data="{ open: false }">
        <button @click="open = !open" class="relative w-full bg-white b-2 border-gray-300 rounded-md shadow-sm pl-3 pr-10 py-2 text-left focus:outline-none focus:ring-0 sm:text-sm">
          <span class="flex items-center">
            <span class="block truncate text-gray-400">
              <%= name %>
            </span>
          </span>
          <span class="ml-3 absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
            <svg class="h-5 w-5 text-gray-600" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
              <path fill-rule="evenodd" d="M10 3a1 1 0 01.707.293l3 3a1 1 0 01-1.414 1.414L10 5.414 7.707 7.707a1 1 0 01-1.414-1.414l3-3A1 1 0 0110 3zm-3.707 9.293a1 1 0 011.414 0L10 14.586l2.293-2.293a1 1 0 011.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z" clip-rule="evenodd" />
            </svg>
          </span>
        </button>
        <div x-show="open" class="absolute right-0 mt-2 origin-top-right rounded-md shadow-2xl">
          <div class="px-2 py-2 bg-white rounded-md shadow dark-mode:bg-gray-800">
            <form phx-change="filter">
              <input type="hidden" name="<%= input_name %>[]" value="0">
              <%= for el <- elements do %>
                <label class="inline-flex mt-3 hover:text-orange-600 w-full">
                  <input
                    class="h-5 w-5 text-yellow-800 border-2 focus:ring-0"
                    type="checkbox"
                    name="<%= input_name %>[]"
                    value="<%= Map.get(el, String.to_atom(value_name)) %>"
                    <%= if to_string(Map.get(el, String.to_atom(value_name))) in Filter.filter_by_name(filter, input_name), do: "checked" %>>
                  <span class="ml-2 text-gray-700"><%= el.name %></span>
                </label>
              <% end %>
            </form>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
