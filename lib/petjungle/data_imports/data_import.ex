defmodule PetJungle.DataImports.DataImport do
  @moduledoc """
    Utility module to ingest `plants.csv`, `pets.csv` and `pet_friendly.csv`
  """

  alias NimbleCSV.RFC4180, as: CSV
  alias Petjungle.Repo
  alias PetJungle.{Plants.Plant, Pets.Pet, PetFriendly.PetFriendly}

  def column_data(file) do
    column_names = get_column_names(file)

    file
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: true)
    |> Enum.map(fn row ->
      row
      |> Enum.with_index()
      |> Map.new(fn {val, num} -> {column_names[num], val} end)
      |> create_or_skip()
    end)
  end

  def get_column_names(file) do
    file
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: false)
    |> Enum.fetch!(0)
    |> Enum.with_index()
    |> Map.new(fn {val, num} -> {num, val} end)
  end

  def create_or_skip(row) do
    maybe_insert(row)
  end

  defp maybe_insert(%{"common_name" => _common_name} = row) do
    case Repo.get_by(Plant,
           common_name: row["common_name"]
         ) do
      nil ->
        Repo.insert(
          %Plant{}
          |> Plant.changeset(%{
            common_name: row["common_name"],
            botanical_name: row["botanical_name"],
            plant_type: row["plant_type"]
          })
        )

      plant ->
        {:ok, plant}
    end
  end

  defp maybe_insert(%{"name" => _name} = row) do
    case Repo.get_by(Pet,
           name: row["name"]
         ) do
      nil ->
        Repo.insert(
          %Pet{}
          |> Pet.changeset(%{
            name: row["name"]
          })
        )

      pet ->
        {:ok, pet}
    end
  end

  defp maybe_insert(%{"plant_id" => _plant_id} = row) do
    Repo.insert(
      %PetFriendly{}
      |> PetFriendly.changeset(%{
        plant_id: row["plant_id"],
        pet_id: row["pet_id"]
      })
    )
  end
end
