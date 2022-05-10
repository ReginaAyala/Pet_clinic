defmodule PetClinic.PetClinicService.PetType do
  @moduledoc """
  This is module Pet Type.
  The schema for pet type and its related with the pet
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "pet_types" do
    field :name_type, :string
    has_many :pets, PetClinic.PetClinicService.Pet, foreign_key: :type_id
    timestamps()
  end
end
