defmodule TobaccosClub.Tobaccos do
  def list_brands do
    File.read!("priv/resources/brands.json")
    |> Jason.decode!()
    |> Enum.map(fn brand ->
      %TobaccosClub.Tobaccos.Brand{name: brand["name"], url: brand["url"]}
    end)
  end

  def list_brands_starting_with(letter) do
    list_brands()
    |> Enum.filter(fn brand -> String.starts_with?(brand.name, letter) end)
  end

  def find_brands_by_name(content) do
    list_brands()
    |> Enum.filter(fn brand -> String.contains?(brand.name, content) end)
  end
end
