defmodule PetJungle.PetFriendly do
  import Ecto.Query, warn: false
  alias Petjungle.Repo
  alias PetJungle.PetFriendly.PetFriendly
  alias PetJungle.Pets.Pet

  def list_pets_for_plant_id(plant_id) do
    PetFriendly
    |> join(:inner, [pf], p in Pet, on: pf.pet_id == p.id)
    |> where([pf, p], pf.plant_id == ^plant_id)
    |> select([pf, p], p.name)
    |> Repo.all()
  end

  def list_petfriendly() do
    PetFriendly |> select([pf], {pf.plant_id, pf.pet_id}) |> Repo.all()
  end
end
