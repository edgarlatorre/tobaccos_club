defmodule TobaccosClubWeb.Blends.ShowLive do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Tobaccos

  @impl true
  def mount(%{"blend_id" => blend_id}, _session, socket) do
    blend = Tobaccos.get_blend!(blend_id)

    {:ok, assign(socket, blend: blend)}
  end
end
