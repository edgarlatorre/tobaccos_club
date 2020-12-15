defmodule TobaccosClub.Pipes.Country do
  use Ecto.Schema
  import Ecto.Changeset

  schema "countries" do
    field :locale, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:name, :locale])
    |> validate_required([:name, :locale])
  end
end
