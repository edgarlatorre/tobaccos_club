defmodule Mix.Tasks.Populate.Blends do
  use Mix.Task

  @shortdoc "Simply calls the TobaccosClub.Services.Populate.blends/0 function."
  def run(_) do
    Mix.Task.run("app.start")

    File.read!("priv/resources/completed_blends.json")
    |> Jason.decode!()
    |> TobaccosClub.Services.Populate.blends()
  end
end
