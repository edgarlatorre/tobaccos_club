defmodule Mix.Tasks.Populate.Brands do
  use Mix.Task

  @shortdoc "Simply calls the TobaccosClub.Services.Populate.brands/1 function."
  def run(_) do
    IO.puts("Populating data")

    Mix.Task.run("app.start")

    File.read!("priv/resources/brands.json")
    |> Jason.decode!()
    |> TobaccosClub.Services.Populate.brands()
  end
end
