defmodule TobaccosClub.Services.Populate do
  alias TobaccosClub.Tobaccos

  def brands() do
    IO.puts("Populating data")

    File.read!("priv/resources/brands.json")
    |> Jason.decode!()
    |> Enum.each(fn brand -> create_brand(brand) end)
  end

  def blend_types() do
    File.read!("priv/resources/completed_blends.json")
    |> Jason.decode!()
    |> Enum.map(fn b -> b["blend_type"] end)
    |> Enum.uniq()
    |> Enum.each(fn bt -> Tobaccos.create_blend_type(%{name: bt}) end)
  end

  defp create_brand(params) do
    slug = List.last(String.split(params["url"], "/"))
    {:ok, _} = Tobaccos.create_brand(%{name: params["name"], url: params["url"], slug: slug})
  end
end
