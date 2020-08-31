defmodule TobaccosClubWeb.Blends.ShowLive do
  use TobaccosClubWeb, :live_view

  alias TobaccosClub.Tobaccos

  @impl true
  def mount(%{"blend_id" => blend_id}, _session, socket) do
    blend = Tobaccos.get_blend!(blend_id)
    blend_type = Tobaccos.get_blend_type!(blend.blend_type_id)
    brand = Tobaccos.get_brand!(blend.brand_id)

    {:ok, assign(socket, blend: blend, blend_type: blend_type, brand: brand)}
  end
end
