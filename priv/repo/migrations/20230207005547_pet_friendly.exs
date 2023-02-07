defmodule Petjungle.Repo.Migrations.PetFriendly do
  use Ecto.Migration

  def change do
    create table(:pet_friendly) do
      add :plant_id, references(:plants), null: false
      add :pet_id, references(:pets), null: false
    end

    create unique_index(:pet_friendly, [:plant_id, :pet_id])
  end
end
