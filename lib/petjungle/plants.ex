defmodule PetJungle.Plants do
  import Ecto.Query, warn: false
  alias Petjungle.Repo
  alias PetJungle.Plants.Plant
  alias PetJungle.PetFriendly.PetFriendly
  alias PetJungle.Pets.Pet

  def list_plants(filter \\ %{}) do
    Plant
    |> filter_with(filter)
    |> Repo.all()
  end

  defp filter_with(query, %{plant_type: filter_value}) do
    query |> where([q], q.plant_type == ^filter_value)
  end

  defp filter_with(query, %{pet_name: filter_value}) do
    pets_subquery = where(Pet, [p], p.name == ^filter_value) |> select([p], p)

    pet_friendly_subquery =
      PetFriendly
      |> join(:inner, [pf], p in subquery(pets_subquery), on: pf.pet_id == p.id)
      |> select([pf, p], pf)

    query
    |> join(:inner, [q], pf in subquery(pet_friendly_subquery), on: q.id == pf.plant_id)
    |> select([q, pf], q)
  end

  defp filter_with(query, %{}) do
    query
  end

  def search_plants(search_phrase) do
    Plant
    |> where([p], fragment("SIMILARITY(?, ?) > 0", p.common_name, ^search_phrase))
    |> order_by([p], fragment("LEVENSHTEIN(?, ?)", p.common_name, ^search_phrase))
    |> Repo.all()
  end

  def change_plant(%Plant{} = plant, attrs \\ %{}) do
    Plant.changeset(plant, attrs)
  end
end
