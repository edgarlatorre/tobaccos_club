defmodule TobaccosClub.Tobaccos.Brand do
  def all do
    read_json()
  end

  defp read_json do
    File.read!("priv/resources/brands.json")
    |> Jason.decode!()
  end
end
