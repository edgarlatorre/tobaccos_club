defmodule Mix.Tasks.PopulateBrands do
  use Mix.Task

  @shortdoc "Simply calls the TobaccosClub.Services.Populate.brands/0 function."
  def run(_) do
    Mix.Task.run("app.start")
    TobaccosClub.Services.Populate.brands()
  end
end
