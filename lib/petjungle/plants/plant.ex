defmodule PetJungle.Plants.Plant do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:common_name, :plant_type]

  @optional_fields [:botanical_name]


  schema "plants" do
    field :common_name, :string
    field :botanical_name, :string
    field :plant_type, Ecto.Enum, values: [:indoor, :outdoor, :both]
    many_to_many :pets, PetJungle.Pets.Pet,
      join_through: PetJungle.PetFriendly.PetFriendly
  end

  def changeset(plant, params \\ %{}) do
    plant
    |> cast(params, @required_fields ++ @optional_fields)
    |> cast_assoc(:pets, required: true)
    |> validate_required(@required_fields)
    |> unique_constraint([:common_name, :botanical_name])
  end

  def plant_types() do
    [:indoor, :outdoor, :both]
  end
end
