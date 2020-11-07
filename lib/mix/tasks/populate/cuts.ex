defmodule Mix.Tasks.Populate.Cuts do
  use Mix.Task

  @shortdoc "Simply calls the TobaccosClub.Services.Populate.cuts/1 function."
  def run(_) do
    Mix.Task.run("app.start")

    File.read!("priv/resources/cuts.json")
    |> Jason.decode!()
    |> TobaccosClub.Services.Populate.cuts()
  end
end
