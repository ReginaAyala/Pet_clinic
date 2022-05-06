defmodule PetClinic.Repo.Migrations.ExpertSpecialities do
  use Ecto.Migration
  import Ecto.Query
  alias PetClinic.Repo
  alias PetClinic.PetClinicService.PetType
  alias PetClinic.PetHealthExpert.Vet

  def change do
    experts_query = "select id, specialities from vets"
    experts = Ecto.Adapters.SQL.query!(Repo, experts_query, [])
    experts = experts.rows

    alter table("vets") do
      remove :specialities
    end

    create table("expert_specialities") do
      add :health_expert_id, references("vets")
      add :pet_type_id, references("pet_types")
    end

    flush()

    Enum.each(experts, fn vet ->
      specialities = vet |> List.last() |> String.split(",")
      expert_id = vet |> List.first()

      Enum.each(specialities, fn speciality ->
        %PetType{id: type_id} = Repo.get_by(PetType, name_type: speciality)
        insert_query = "insert into expert_specialities (health_expert_id, pet_type_id)
                        values ($1::integer, $2::integer)"
        Ecto.Adapters.SQL.query!(Repo, insert_query, [expert_id, type_id])
      end)
    end)
  end
end
