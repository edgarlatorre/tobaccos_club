defmodule TobaccosClub.Pipes.Blend do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blends" do
    field :blended_by, :string
    field :contents, :string
    field :flavouring, :string
    field :image_url, :string
    field :manufactured_by, :string
    field :name, :string
    field :packaging, :string
    field :production, :string
    field :slug, :string

    belongs_to :brand, TobaccosClub.Pipes.Brand
    belongs_to :blend_type, TobaccosClub.Pipes.BlendType
    belongs_to :cut, TobaccosClub.Pipes.Cut
    belongs_to :country, TobaccosClub.Pipes.Country

    timestamps()
  end

  @doc false
  def changeset(blend, attrs) do
    blend
    |> cast(attrs, [
      :name,
      :brand_id,
      :blend_type_id,
      :blended_by,
      :manufactured_by,
      :contents,
      :flavouring,
      :cut_id,
      :packaging,
      :country_id,
      :production,
      :image_url,
      :slug
    ])
    |> unique_constraint(:slug)
  end
end
