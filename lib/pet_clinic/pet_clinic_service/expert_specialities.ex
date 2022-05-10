defmodule PetClinic.PetClinicService.ExpertSpecialities do
  @moduledoc """
   This is module Expert Specialities.
   the data schema is created for a expert specialities and the related with the pet type, 
   and the vet.
  """
  use Ecto.Schema

  schema "expert_specialities" do
    belongs_to :type, PetClinic.PetClinicService.Pet, foreign_key: :pet_type_id
    belongs_to :health_expert, PetClinic.PetHealthExpert.Vet, foreign_key: :health_expert_id
  end
end
