defmodule PetJungle.PetFriendly.PetFriendly do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:plant_id, :pet_id]

  schema "pet_friendly" do
    belongs_to :plant, PetJungle.Plants.Plant
    belongs_to :pet, PetJungle.Pets.Pet
  end

  def changeset(pet_friendly, params \\ %{}) do
    pet_friendly
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint([:plant_id, :pet_id])
  end
end
