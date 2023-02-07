defmodule PetJungle.Plants do
  import Ecto.Query, warn: false
  alias Petjungle.Repo
  alias PetJungle.Plants.Plant

  def list_plants() do
    Plant |> Repo.all()
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
