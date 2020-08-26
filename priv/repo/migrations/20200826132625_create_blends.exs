defmodule TobaccosClub.Repo.Migrations.CreateBlends do
  use Ecto.Migration

  def change do
    create table(:blends) do
      add :name, :string
      add :blended_by, :string
      add :manufactured_by, :string
      add :contents, :string
      add :flavouring, :string
      add :cut, :string
      add :packaging, :string
      add :country, :string
      add :production, :string
      add :image_url, :string
      add :blend_type_id, references(:blend_types, on_delete: :nothing)
      add :brand_id, references(:brands, on_delete: :nothing)

      timestamps()
    end

    create index(:blends, [:blend_type_id])
    create index(:blends, [:brand_id])
  end
end
