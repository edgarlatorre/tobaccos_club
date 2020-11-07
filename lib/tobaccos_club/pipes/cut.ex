defmodule TobaccosClub.Pipes.Cut do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cuts" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(cut, attrs) do
    cut
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
