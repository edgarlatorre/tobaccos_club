defmodule TobaccosClubWeb.Schema do
  use Absinthe.Schema

  alias TobaccosClub.Pipes
  alias TobaccosClub.Reviewer

  query do
    @desc "List cuts of tobaccos"
    field :cuts, list_of(:cut) do
      resolve(fn _, _, _ ->
        {:ok, Pipes.list_cuts()}
      end)
    end

    @desc "List brands of tobaccos"
    field :brands, list_of(:brand) do
      resolve(fn _, _, _ ->
        {:ok, Reviewer.list_brands()}
      end)
    end

    @desc "List blend types of tobaccos"
    field :blend_types, list_of(:blend_type) do
      resolve(fn _, _, _ ->
        {:ok, Reviewer.list_blend_types()}
      end)
    end

    @desc "List countries"
    field :countries, list_of(:country) do
      resolve(fn _, _, _ ->
        {:ok, Pipes.list_countries()}
      end)
    end

    @desc "List blends"
    field :blends, list_of(:blend) do
      resolve(fn _, _, _ ->
        {:ok, Reviewer.list_blends_eager()}
      end)
    end
  end

  object :cut do
    field(:id, :id)
    field(:name, :string)
  end

  object :brand do
    field(:id, :id)
    field(:name, :string)
  end

  object :blend_type do
    field(:id, :id)
    field(:name, :string)
  end

  object :country do
    field(:id, :id)
    field(:name, :string)
  end

  object :blend do
    field(:id, :id)
    field(:name, :string)
    field(:blend_type, :blend_type)
    field(:brand, :brand)
    field(:cut, :cut)
    field(:contents, :string)
    field(:country, :country)
    field(:manufactured_by, :string)
    field(:flavouring, :string)
    field(:packaging, :string)
    field(:production, :string)
    field(:image_url, :string)
    field(:slug, :string)
  end
end
