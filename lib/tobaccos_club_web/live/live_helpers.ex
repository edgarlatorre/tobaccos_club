defmodule TobaccosClubWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
  import TobaccosClubWeb.Gettext

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
          <nav class="relative z-0 inline-flex">
            <%= live_patch to: Routes.blends_index_path(@socket, @route, page: @pagination_info.page_number - 1), class: "relative inline-flex items-center px-2 py-2 rounded-r-md border-0 bg-white text-sm leading-5 font-medium text-gray-500 hover:text-gray-400 active:bg-gray-100 active:text-gray-500 transition ease-in-out duration-150" do %>
              <%= svg_image_tag("previous-icon") %>
            <% end %>
            <%= live_patch to: Routes.blends_index_path(@socket, @route, page: @pagination_info.page_number + 1), class: "relative inline-flex items-center px-2 py-2 rounded-r-md border-0 bg-white text-sm leading-5 font-medium text-gray-500 hover:text-gray-400 active:bg-gray-100 active:text-gray-500 transition ease-in-out duration-150" do %>
              <%= svg_image_tag("next-icon") %>
            <% end %>
          </nav>
        </div>
      </div>
    </div>
    """
  end

  def live_modal(_socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(TobaccosClubWeb.ModalComponent, modal_opts)
  end

  def svg_image_tag(name) do
    TobaccosClubWeb.LayoutView.svg_image_tag(name)
  end
end
