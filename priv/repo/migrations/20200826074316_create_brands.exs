defmodule TobaccosClub.Repo.Migrations.CreateBrands do
  use Ecto.Migration

  def change do
    create table(:brands) do
      add :name, :string
      add :slug, :string
      add :url, :string

      timestamps()
    end
  end
end
