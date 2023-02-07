defmodule Petjungle.Repo.Migrations.PlantTypes do
  use Ecto.Migration
  import EctoEnumMigration

  def change do
    create_type(:plant_type, [:indoor, :outdoor, :both])
  end
end
