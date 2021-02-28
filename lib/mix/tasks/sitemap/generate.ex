defmodule Mix.Tasks.Sitemap.Generate do
  use Mix.Task
  alias TobaccosClub.Reviewer
  alias TobaccosClub.Services.SitemapGenerator
  alias TobaccosClub.Services.Storage

  @shortdoc "generate sitemap.xml and upload it to S3"
  def run(_args) do
    Mix.Task.run("app.start")

    blends = Reviewer.list_blends(brand: true)
    sitemap_content = SitemapGenerator.generate(blends)
    sitemap_filename = Application.get_env(:tobaccos_club, :sitemap_file)

    temporary_directory = System.tmp_dir!()
    temporary_file = Path.join(temporary_directory, sitemap_filename)
    File.write!(temporary_file, sitemap_content)

    upload(temporary_file, sitemap_filename)
  end

  defp upload(path, name) do
    IO.puts("Upload: #{name}")
    Storage.upload_file(path, name)
  end
end
