defmodule Mix.Tasks.UploadImages do
  use Mix.Task
  alias TobaccosClub.Reviewer
  alias TobaccosClub.Services.Storage

  @shortdoc "Upload photos to S3"
  def run(args) do
    dir = List.first(args)

    Mix.Task.run("app.start")

    Reviewer.list_blends_with_labels()
    |> Enum.map(fn blend ->
      name =
        blend.image_url
        |> String.split("/")
        |> List.last()

      path = "#{dir}#{name}"
      IO.puts("Calling: #{name}")
      {name, path}
    end)
    |> Task.async_stream(fn {name, path} ->
      if String.contains?(name, "?") do
        IO.puts("SKIP: #{name}")
      else
        upload(path, name)
      end
    end)
    |> Enum.to_list()
  end

  defp upload(path, name) do
    IO.puts("Upload: #{name}")
    Storage.upload_file(path, name)
  end
end
