defmodule TobaccosClubWeb.BlendsLive.Show do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Reviewer

  @impl true
  def mount(%{"blend_id" => blend_id}, _session, socket) do
    {:ok, assign(socket, blend: Reviewer.get_blend!(blend_id))}
  end
end
