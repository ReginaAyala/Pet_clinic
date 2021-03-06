defmodule PetClinic.PetHealthExpert.Vet do
  @moduledoc """
   This is module Vet.
   the data schema is created for a veterinarian and the related with the pet, 
   the pet owner, their specialty and their appointments
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "vets" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]
    # field :specialities, :string

    has_many(:pets, PetClinic.PetClinicService.Pet, foreign_key: :preferred_expert_id)

    many_to_many :specialities, PetClinic.PetClinicService.PetType,
      join_through: PetClinic.PetClinicService.ExpertSpecialities,
      join_keys: [pet_type_id: :id, health_expert_id: :id]

    has_many :appoinments, PetClinic.AppoinmentService.Appointments,
      foreign_key: :health_expert_id

    timestamps()
  end

  @doc false
  def changeset(vet, attrs) do
    vet
    |> cast(attrs, [:name, :age, :email, :sex])
    # |> cast_assoc(:specialities, required: true)
    |> validate_required([:name, :age, :email, :sex])
  end
end
