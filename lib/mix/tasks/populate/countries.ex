defmodule Mix.Tasks.Populate.Countries do
  use Mix.Task

  alias TobaccosClub.Pipes

  @shortdoc "Simply calls the TobaccosClub.Services.Populate.countries/1 function."
  def run(_) do
    Mix.Task.run("app.start")

    Enum.each(list_countries(), &Pipes.create_country/1)
  end

  def list_countries do
    [
      %{locale: "US", name: "United States"},
      %{locale: "DK", name: "Denmark"},
      %{locale: "UK", name: "United Kingdom"},
      %{locale: "DE", name: "Germany"},
      %{locale: "CA", name: "Canada"},
      %{locale: "SE", name: "Sweden"},
      %{locale: "AR", name: "Argentina"},
      %{locale: "AT", name: "Austria"},
      %{locale: "FR", name: "France"},
      %{locale: "TR", name: "Turkey"},
      %{locale: "IT", name: "Italy"},
      %{locale: "IE", name: "Ireland"},
      %{locale: "CH", name: "Switzerland"},
      %{locale: "BR", name: "Brazil"},
      %{locale: "NL", name: "Netherlands"},
      %{locale: "RU", name: "Russia"},
      %{locale: "BE", name: "Belgium"},
      %{locale: "PT", name: "Portugal"},
      %{locale: "MX", name: "Mexico"},
      %{locale: "JP", name: "Japan"},
      %{locale: "ID", name: "Indonesia"},
      %{locale: "ZA", name: "South Africa"},
      %{locale: "CZ", name: "Czech Republic"},
      %{locale: "GR", name: "Greece"}
    ]
  end
end
