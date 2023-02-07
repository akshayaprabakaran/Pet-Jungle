defmodule PetJungle.PetFriendly.PetFriendly do
  use Ecto.Schema

  schema "pet_friendly" do
    belongs_to :plant, PetJungle.Plants.Plant
    belongs_to :pet, PetJungle.Pets.Pet
  end
end
