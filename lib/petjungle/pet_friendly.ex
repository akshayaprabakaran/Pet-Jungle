defmodule PetJungle.PetFriendly do
  import Ecto.Query, warn: false
  alias Petjungle.Repo
  alias PetJungle.PetFriendly.PetFriendly
  alias PetJungle.Pets.Pet

  def list_petfriendly() do
    PetFriendly
    |> join(:inner, [pf], p in Pet, on: pf.pet_id == p.id)
    |> select([pf, p], {pf.plant_id, p.name})
    |> Repo.all()
  end
end
