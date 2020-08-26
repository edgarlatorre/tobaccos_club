defmodule TobaccosClub.Tobaccos.BlendType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blend_types" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(blend_type, attrs) do
    blend_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
