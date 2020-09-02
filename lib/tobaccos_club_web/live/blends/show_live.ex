defmodule TobaccosClubWeb.Blends.ShowLive do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Reviewer

  @impl true
  def mount(%{"blend_id" => blend_id}, _session, socket) do
    blend = Reviewer.get_blend!(blend_id)
    blend_type = Reviewer.get_blend_type!(blend.blend_type_id)
    brand = Reviewer.get_brand!(blend.brand_id)

    {:ok, assign(socket, blend: blend, blend_type: blend_type, brand: brand)}
  end
end
