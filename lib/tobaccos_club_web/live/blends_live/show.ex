defmodule TobaccosClubWeb.BlendsLive.Show do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Reviewer

  @impl true
  def mount(%{"blend_slug" => blend_slug}, _session, socket) do
    {:ok, assign(socket, blend: Reviewer.get_blend_by_slug(blend_slug))}
  end

  @impl true
  def handle_params(%{"blend_slug" => blend_slug}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Testing")
     |> assign(:user, Reviewer.get_blend_by_slug(blend_slug))}
  end
end
