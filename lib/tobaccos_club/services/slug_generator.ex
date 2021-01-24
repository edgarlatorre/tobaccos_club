defmodule TobaccosClub.Services.SlugGenerator do
  alias TobaccosClub.Repo

  def generate(text, schema) do
    slug =
      text
      |> String.downcase()
      |> String.replace(" ", "-")

    if Repo.get_by(schema, slug: slug) do
      generate(slug, schema, 1)
    else
      slug
    end
  end

  def generate(text, schema, counter) do
    slug = "#{create_slug(text)}-#{counter}"

    if Repo.get_by(schema, slug: slug) do
      generate(text, schema, counter + 1)
    else
      slug
    end
  end

  defp create_slug(text) do
    text
    |> String.downcase()
    |> String.replace(" ", "-")
  end
end
