defmodule TobaccosClub.Pipes.Blend do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blends" do
    field :blended_by, :string
    field :contents, :string
    field :country, :string
    field :cut, :string
    field :flavouring, :string
    field :image_url, :string
    field :manufactured_by, :string
    field :name, :string
    field :packaging, :string
    field :production, :string

    belongs_to :brand, TobaccosClub.Pipes.Brand
    belongs_to :blend_type, TobaccosClub.Pipes.BlendType

    timestamps()
  end

  @doc false
  def changeset(blend, attrs) do
    cast(blend, attrs, [
      :name,
      :brand_id,
      :blend_type_id,
      :blended_by,
      :manufactured_by,
      :contents,
      :flavouring,
      :cut,
      :packaging,
      :country,
      :production,
      :image_url
    ])
  end
end
