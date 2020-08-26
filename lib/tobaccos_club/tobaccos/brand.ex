defmodule TobaccosClub.Tobaccos.Brand do
  use Ecto.Schema
  import Ecto.Changeset

  schema "brands" do
    field :name, :string
    field :slug, :string
    field :url, :string
    has_many :blends, TobaccosClub.Tobaccos.Blend

    timestamps()
  end

  @doc false
  def changeset(brand, attrs) do
    brand
    |> cast(attrs, [:name, :slug, :url])
    |> validate_required([:name, :slug, :url])
    |> unique_constraint([:name, :slug])
  end
end
