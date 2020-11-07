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
    <div @click.away="open = false" class="relative" x-data="{ open: false }">
      <button @click="open = !open" class="flex flex-row items-center px-4 py-2 mt-2 text-sm font-semibold text-left bg-transparent rounded-lg dark-mode:bg-transparent dark-mode:focus:text-white dark-mode:hover:text-white dark-mode:focus:bg-gray-600 dark-mode:hover:bg-orange-100 md:block hover:text-gray-900 focus:text-gray-900 hover:bg-orange-100 focus:bg-orange-100 focus:outline-none focus:shadow-outline">
        <span><%= name %></span>
        <svg fill="currentColor" viewBox="0 0 20 20" :class="{'rotate-180': open, 'rotate-0': !open}" class="inline w-4 h-4 mt-1 ml-1 transition-transform duration-200 transform md:-mt-1"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
      </button>
      <div x-show="open" x-transition:enter="transition ease-out duration-100" x-transition:enter-start="transform opacity-0 scale-95" x-transition:enter-end="transform opacity-100 scale-100" x-transition:leave="transition ease-in duration-75" x-transition:leave-start="transform opacity-100 scale-100" x-transition:leave-end="transform opacity-0 scale-95" class="absolute right-0 mt-2 origin-top-right rounded-md shadow-lg">
        <div class="px-2 py-2 bg-white rounded-md shadow dark-mode:bg-gray-800">
          <form phx-change="filter">
            <input type="hidden" name="<%= input_name %>[]" value="0"/>
            <%= for el <- elements do %>
              <label class="inline-flex mt-3 hover:text-orange-600">
                <input
                  class="form-checkbox h-5 w-5 text-gray-600"
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
    """
  end
end
