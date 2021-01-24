defmodule Mix.Tasks.Populate.BlendSlugs do
  use Mix.Task

  alias TobaccosClub.Pipes.Blend
  alias TobaccosClub.Reviewer
  alias TobaccosClub.Services.SlugGenerator

  @shortdoc "Simply calls the TobaccosClub.Services.Populate.blends/0 function."
  def run(_) do
    Mix.Task.run("app.start")

    Enum.each(Reviewer.list_blends(), fn blend ->
      slug = SlugGenerator.generate(blend.name, Blend)
      IO.puts("Add slug: #{slug} to blend #{blend.name}")
      Reviewer.update_blend(blend, %{slug: slug})
    end)
  end
end
