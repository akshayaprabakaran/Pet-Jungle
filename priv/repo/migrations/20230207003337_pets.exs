defmodule Petjungle.Repo.Migrations.Pets do
  use Ecto.Migration

  def change do
    create table(:pets) do
      add :name, :string, null: false
    end

    create unique_index(:pets, [:name])
  end
end
