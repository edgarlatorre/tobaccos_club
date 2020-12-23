defmodule TobaccosClubWeb.FilterComponent do
  use TobaccosClubWeb, :live_component
  alias TobaccosClub.Pipes.Filter

  def render(assigns) do
    ~L"""
    <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
      <div x-on:click.away="<%= @input_name %> = false" class="relative border-2 border-gray-300 rounded-lg">
        <button x-on:click="<%= @input_name %> = !<%= @input_name %>" class="relative w-full bg-white b-2 border-gray-300 rounded-md shadow-sm pl-3 pr-10 py-2 text-left focus:outline-none focus:ring-0 sm:text-sm">
          <span class="flex items-center">
            <span class="block truncate text-gray-400">
              <%= @name %>
            </span>
          </span>
          <span class="ml-3 absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
            <svg class="h-5 w-5 text-gray-600" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
              <path fill-rule="evenodd" d="M10 3a1 1 0 01.707.293l3 3a1 1 0 01-1.414 1.414L10 5.414 7.707 7.707a1 1 0 01-1.414-1.414l3-3A1 1 0 0110 3zm-3.707 9.293a1 1 0 011.414 0L10 14.586l2.293-2.293a1 1 0 011.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z" clip-rule="evenodd" />
            </svg>
          </span>
        </button>
        <div x-show="<%= @input_name %>" class="absolute right-0 mt-2 origin-top-right rounded-md shadow-2xl z-10">
          <div class="px-2 py-2 bg-white rounded-md shadow dark-mode:bg-gray-800">
            <form phx-change="filter">
              <input type="hidden" name="<%= @input_name %>[]" value="0">
              <%= for el <- @elements do %>
                <label class="inline-flex mt-3 hover:text-orange-600 w-full">
                  <input
                    class="h-5 w-5 text-yellow-800 border-2 focus:ring-0"
                    type="checkbox"
                    name="<%= @input_name %>[]"
                    value="<%= el.id %>"
                    <%= if to_string(el.id) in Filter.filter_by_name(@filter, @input_name), do: "checked" %>>
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
