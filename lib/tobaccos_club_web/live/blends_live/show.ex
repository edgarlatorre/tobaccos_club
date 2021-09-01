defmodule TobaccosClubWeb.BlendsLive.Show do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Reviewer

  @impl true
  def mount(%{"blend_slug" => blend_slug}, %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)
    {:ok, assign(socket, blend: Reviewer.get_blend_by_slug(blend_slug), locale: locale)}
  end

  @impl true
  def handle_params(%{"blend_slug" => blend_slug}, _, socket) do
    blend = Reviewer.get_blend_by_slug(blend_slug)

    {:noreply,
     socket
     |> assign(:page_title, page_title(blend))
     |> assign(:user, Reviewer.get_blend_by_slug(blend_slug))}
  end

  defp page_title(blend) do
    "#{gettext("Tobacco's Club")} - #{blend.name}"
  end
end
