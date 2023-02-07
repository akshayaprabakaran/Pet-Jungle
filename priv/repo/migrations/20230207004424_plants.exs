defmodule Petjungle.Repo.Migrations.Plants do
  use Ecto.Migration

  def change do
    create table(:plants) do
      add :common_name, :string, null: false
      add :botanical_name, :string, null: true
      add :plant_type, :plant_type, null: false
    end

    create unique_index(:plants, [:common_name])
    create unique_index(:plants, [:botanical_name])
  end
end
