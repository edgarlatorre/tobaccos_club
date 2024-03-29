defmodule TobaccosClub.Repo.Migrations.ChangeCountryFieldFromBlends do
  use Ecto.Migration

  def change do
    alter table(:blends) do
      remove :country
      add :country_id, references(:countries)
    end

    create index(:blends, [:country_id])
  end
end
