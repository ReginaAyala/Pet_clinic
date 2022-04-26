defmodule PetClinic.Repo.Migrations.CorrectVetSex do
  use Ecto.Migration
  alias PetClinic.Repo
  def change do
    query_sex = "update vets set sex = 'male' where sex != 'male' and sex != 'female'"
    Ecto.Adapters.SQL.query!(Repo, query_sex, [])
    query_low = "update vets set sex =  lower(sex)"
    Ecto.Adapters.SQL.query!(Repo, query_low, [])
  end
end
