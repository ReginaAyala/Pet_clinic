datedefmodule PetClinic.Repo.Migrations.CreateAppoinmentService do
  use Ecto.Migration

  def change do
    create table("appointments") do
      add :date_time, :naive_datetime
      add :pet_id, references("pets")
      add :health_expert_id, references("vets")

    end
  end
end
