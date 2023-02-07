defmodule PetJungle.Pets.Pet do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:name]

  schema "pets" do
    field :name, :string
  end

  def changeset(pet, params \\ %{}) do
    pet
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint([:name])
  end
end
