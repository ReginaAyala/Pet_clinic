defmodule PetClinic.PetClinicService.Pet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pets" do
    field :age, :integer
    field :name, :string
    field :sex, :string
    field :type, :string
    belongs_to(:owner, PetClinic.PetClinicService.Owner)
    belongs_to(:preferred_expert, PetClinic.PetHealthExpert.Vet, foreign_key: :preferred_expert_id)
    timestamps()
  end

  @doc false
  def changeset(pet, attrs \\%{}) do
    pet
    |> cast(attrs, [:name, :age, :type, :sex])
    |> validate_required([:name, :age, :type, :sex])
    |> validate_number(:age, greater_than_or_equal_to: 0)

  end
  
end
