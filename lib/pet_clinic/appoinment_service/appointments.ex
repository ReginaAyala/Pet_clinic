defmodule PetClinic.AppoinmentService.Appointments do 
    use Ecto.Schema
     
    schema "appointments" do 
        field :date_time, :naive_datetime
        belongs_to :pets, PetClinic.PetClinicService.Pet, foreign_key: :pet_id
        belongs_to :health_expert, PetClinic.PetHealthExpert.Vet, foreign_key: :health_expert_id
    end
end