defmodule PetClinic.PetClinicService.Pet do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
   This is module Pet.
   the data schema is created for a pet and the related with the veterinarian, 
   the pet owner, type and appoinments.
  """
  schema "pets" do
    field :age, :integer
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]

    # field :type, :string
    belongs_to(:pet_type, PetClinic.PetClinicService.PetType, foreign_key: :type_id)
    belongs_to(:owner, PetClinic.PetClinicService.Owner)

    belongs_to(:preferred_expert, PetClinic.PetHealthExpert.Vet, foreign_key: :preferred_expert_id)

    has_many :appoinments, PetClinic.AppoinmentService.Appointments, foreign_key: :pet_id
    timestamps()
  end

  @doc false
  def changeset(pet, attrs \\ %{}) do
    pet
    |> cast(attrs, [:name, :age, :type_id, :sex, :owner_id, :preferred_expert_id])
    |> validate_required([:name, :age, :type_id, :sex, :owner_id, :preferred_expert_id])
    |> validate_number(:age, greater_than_or_equal_to: 0)
  end
end
