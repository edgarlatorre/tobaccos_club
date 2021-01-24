defmodule TobaccosClub.Repo.Migrations.AddSlugToBlends do
  use Ecto.Migration

  def change do
    alter table(:blends) do
      add :slug, :string
    end

    create unique_index(:blends, [:slug])
  end
end
