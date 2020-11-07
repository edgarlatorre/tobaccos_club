defmodule TobaccosClub.Repo.Migrations.CreateCuts do
  use Ecto.Migration

  def change do
    create table(:cuts) do
      add :name, :string

      timestamps()
    end
  end
end
