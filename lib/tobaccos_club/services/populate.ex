defmodule TobaccosClub.Services.Populate do
  alias TobaccosClub.Pipes
  alias TobaccosClub.Reviewer

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
    |> Enum.each(fn bt -> Reviewer.create_blend_type(%{name: bt}) end)
  end

  def cuts(cuts_data) do
    Enum.each(cuts_data, fn cut -> Pipes.create_cut(cut) end)
  end

  defp create_brand(params) do
    slug = List.last(String.split(params["url"], "/"))
    {:ok, _} = Reviewer.create_brand(%{name: params["name"], url: params["url"], slug: slug})
  end

  defp create_blend(params) do
    brand = Reviewer.get_brand_by_name(params["brand"])
    blend_type = Reviewer.get_blend_type_by_name(params["blend_type"])
    country = if params["country"], do: Pipes.get_country_by_locale(params["country"]), else: nil
    cut = if params["cut"], do: Pipes.get_cut_by_name(params["cut"]), else: nil
    cut_id = if cut, do: cut.id, else: nil
    country_id = if country, do: country.id, else: nil

    blend = %{
      brand_id: brand.id,
      blend_type_id: blend_type.id,
      name: params["name"],
      blended_by: params["blended_by"],
      manufactured_by: params["manufactured_by"],
      contents: params["contents"],
      flavouring: params["flavouring"],
      cut_id: cut_id,
      packaging: params["packaging"],
      country_id: country_id,
      production: params["production"],
      image_url: params["image"]
    }

    Reviewer.create_blend(blend)
  end
end
