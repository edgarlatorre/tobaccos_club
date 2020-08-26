defmodule TobaccosClub.Services.Populate do
  alias TobaccosClub.Tobaccos

  def brands() do
    IO.puts("Populating data")

    File.read!("priv/resources/brands.json")
    |> Jason.decode!()
    |> Enum.each(fn brand -> create_brand(brand) end)
  end

  defp create_brand(params) do
    slug = List.last(String.split(params["url"], "/"))
    {:ok, _} = Tobaccos.create_brand(%{name: params["name"], url: params["url"], slug: slug})
  end
end
