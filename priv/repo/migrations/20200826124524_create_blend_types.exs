defmodule TobaccosClub.Repo.Migrations.CreateBlendTypes do
  use Ecto.Migration

  def change do
    create table(:blend_types) do
      add :name, :string

      timestamps()
    end

    create unique_index(:blend_types, [:name])
  end
end
