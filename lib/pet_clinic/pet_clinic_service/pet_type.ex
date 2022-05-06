defmodule PetClinic.PetClinicService.PetType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pet_types" do
    field :name_type, :string
    has_many :pets, PetClinic.PetClinicService.Pet, foreign_key: :type_id
    timestamps()
  end
end
