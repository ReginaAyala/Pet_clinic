defmodule PetClinic.Repo.Migrations.CreatePetTypes do
  use Ecto.Migration
  alias PetClinic.Repo
  alias PetClinic.PetClinicService.Pet

  def change do
    types = "select distinct type from pets"
    types = Ecto.Adapters.SQL.query!(Repo, types, [])
    types = types.rows |> List.flatten()

    pet_type = "select id, type from pets"
    pet_type = Ecto.Adapters.SQL.query!(Repo, pet_type, [])
    pet_type = pet_type.rows

    create table("pet_types") do
      add :name_type, :string
      timestamps()
    end

    flush()

    Enum.each(types, fn x ->
      insert =
        "insert into pet_types (name_type, inserted_at, updated_at) values($1::varchar, current_timestamp, current_timestamp)"

      Ecto.Adapters.SQL.query!(Repo, insert, [x])
    end)

    alter table("pets") do
      remove :type
      add :type_id, references("pet_types")
    end

    flush()

    Enum.each(pet_type, fn x ->
      id = List.first(x)
      type = List.last(x)
      select = "select id from pet_types where name_type = $1::varchar"
      select = Ecto.Adapters.SQL.query!(Repo, select, [type])
      pet_type_id = select.rows |> List.flatten() |> List.first()
      update = "update pets set type_id = $1::integer where id = $2::integer"
      Ecto.Adapters.SQL.query!(Repo, update, [pet_type_id, id])
    end)
  end
end
