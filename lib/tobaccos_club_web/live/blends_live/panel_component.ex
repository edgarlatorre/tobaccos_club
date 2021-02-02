defmodule TobaccosClubWeb.BlendsLive.PanelComponent do
  use TobaccosClubWeb, :live_component

  defp generate_url(image_url) do
    response =
      ExAws.S3.presigned_url(
        ExAws.Config.new(:s3),
        :get,
        Application.get_env(:ex_aws, :bucket),
        image_url
      )

    case response do
      {:ok, url} -> url
      _ -> ""
    end
  end

  @impl true
  def render(assigns) do
    ~L"""
    <div x-show.transition.duration.200ms="showBlend" class="fixed self-start bg-white border border-gray-100 w-5/6 sm:w-2/5 shadow-2xl mb-4">
      <div class="flex justify-end border-b-2 p-3">
        <a href="#" @click="showBlend = false" phx-click="show_blend" phx-value-id="">
          <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              class="h-4 w-4 self-end">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </a>
      </div>
      <%= if @blend do %>
        <div class="flex justify-between">
          <div class="flex flex-col">
            <h3 class="text-2xl sm:text-4xl text-yellow-800 text-left p-2 mt-2"><%= @blend.name %></h3>
            <div class="text-yellow-800 px-2">
              <%= gettext("By") %>: <span><%= @blend.brand.name %></span>
            </div>
          </div>
          <%= if @blend.image_url do %>
            <div class="px-3 mt-3 flex flex-col justify-center items-center">
              <img src="<%= generate_url(@blend.image_url) %>" class="h-40 w-40 border-2 border-gray-100 border-opacity-25 rounded-lg">
            </div>
          <% end %>
        </div>
        <div class="px-3 mt-3">
          <p class="text-yellow-800"><%= gettext("Blended By") %></p>
          <p><%= @blend.blended_by %></p>
        </div>
        <div class="px-3 mt-3">
          <p class="text-yellow-800"><%= gettext("Blend Type") %></p>
          <p><%= @blend.blend_type.name %></p>
        </div>
        <div class="px-3 mt-3">
          <p class="text-yellow-800"><%= gettext("Cut") %></p>
          <p><%= @blend.cut.name %></p>
        </div>
        <div class="px-3 mt-3">
          <p class="text-yellow-800"><%= gettext("Contents") %></p>
          <p><%= @blend.contents %></p>
        </div>
        <div class="px-3 mt-3">
          <p class="text-yellow-800"><%= gettext("Country") %></p>
          <p><%= Gettext.gettext(TobaccosClubWeb.Gettext, @blend.country.name) %></p>
        </div>
        <div class="px-3 mt-3 pb-2">
          <p class="text-yellow-800"><%= gettext("Availability") %></p>
          <p><%= Gettext.gettext(TobaccosClubWeb.Gettext, @blend.production) %></p>
        </div>
      <% end %>
    </div>
    """
  end
end
