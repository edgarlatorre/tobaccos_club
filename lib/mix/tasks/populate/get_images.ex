defmodule Mix.Tasks.Populate.GetImages do
  use Mix.Task
  alias TobaccosClub.Reviewer

  @blends_path "assets/static/images/blends/"

  @shortdoc "Simply calls the TobaccosClub.Services.Populate.get_images/1 function."
  def run(_) do
    Mix.Task.run("app.start")
    IO.puts("Getting images")

    image_urls =
      Reviewer.list_blends()
      |> Enum.filter(fn b -> b.image_url != nil && b.image_url != "" end)
      |> Enum.map(fn b -> "https:#{b.image_url}" end)

    Enum.each(image_urls, fn url ->
      IO.puts("Saving image: #{image_name(url)}")
      %HTTPoison.Response{body: body} = HTTPoison.get!(url)
      File.write!("#{@blends_path}#{image_name(url)}", body)
    end)
  end

  defp image_name(url) do
    url
    |> String.split("/")
    |> List.last()
  end
end
