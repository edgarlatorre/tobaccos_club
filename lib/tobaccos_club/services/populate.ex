defmodule TobaccosClub.Services.Populate do
  alias TobaccosClub.Tobaccos

  def brands(brands_data) do
    Enum.each(brands_data, fn brand -> create_brand(brand) end)
  end

  def blends(blends_data) do
    Enum.each(blends_data, fn params -> create_blend(params) end)
  end

  def blend_types(blend_types_data) do
    blend_types_data
    |> Enum.map(fn b -> b["blend_type"] end)
    |> Enum.uniq()
    |> Enum.each(fn bt -> Tobaccos.create_blend_type(%{name: bt}) end)
  end

  defp create_brand(params) do
    slug = List.last(String.split(params["url"], "/"))
    {:ok, _} = Tobaccos.create_brand(%{name: params["name"], url: params["url"], slug: slug})
  end

  defp create_blend(params) do
    brand = Tobaccos.get_brand_by_name(params["brand"])
    blend_type = Tobaccos.get_blend_type_by_name(params["blend_type"])

    blend = %{
      brand_id: brand.id,
      blend_type_id: blend_type.id,
      name: params["name"],
      blended_by: params["blended_by"],
      manufactured_by: params["manufactured_by"],
      contents: params["contents"],
      flavouring: params["flavouring"],
      cut: params["cut"],
      packaging: params["packaging"],
      country: params["country"],
      production: params["production"],
      image_url: params["image"]
    }

    Tobaccos.create_blend(blend)
  end
end
