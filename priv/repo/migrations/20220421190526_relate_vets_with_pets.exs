defmodule PetClinic.Repo.Migrations.RelateVetsWithPets do
  use Ecto.Migration 

  def change do
    alter table ("pets") do 
    add :vet_id, references("vets")
    end
  end
end
