defmodule PetClinicWeb.PetController do
  use PetClinicWeb, :controller

  alias PetClinic.PetClinicService
  alias PetClinic.PetClinicService.Pet
  alias PetClinic.PetHealthExpert
  alias PetClinic.PetClinicService.PetType

  def index(conn, _params) do
    pets = PetClinicService.list_pets() 
    render(conn, "index.html", pets: pets)
  end

  def new(conn, _params) do
    changeset = PetClinicService.change_pet(%Pet{})
    pet_types = PetClinicService.list_pet_types()
    experts = PetClinic.PetHealthExpert.list_vets()
    owners = PetClinicService.list_owners()
    render(conn, "new.html", changeset: changeset, pet_types: pet_types, owner: owners, vet: experts)
  end

  def create(conn, %{"pet" => pet_params}) do
    case PetClinicService.create_pet(pet_params) do
      {:ok, pet} ->
        conn
        |> put_flash(:info, "Pet created successfully.")
        |> redirect(to: Routes.pet_path(conn, :show, pet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pet = PetClinicService.get_pet!(id)
    owner = PetClinicService.get_owner!(pet.owner_id)
    expert = PetClinic.PetHealthExpert.get_vet!(pet.preferred_expert_id)
    render(conn, "show.html", pet: pet, owner: owner, vet: expert)
  end

  def edit(conn, %{"id" => id}) do
    pet = PetClinicService.get_pet!(id)
    changeset = PetClinicService.change_pet(pet)
    pet_types = PetClinicService.list_pet_types()
    render(conn, "edit.html", pet: pet, changeset: changeset, pet_types: pet_types)
  end

  def update(conn, %{"id" => id, "pet" => pet_params}) do
    pet = PetClinicService.get_pet!(id)

    case PetClinicService.update_pet(pet, pet_params) do
      {:ok, pet} ->
        conn
        |> put_flash(:info, "Pet updated successfully.")
        |> redirect(to: Routes.pet_path(conn, :show, pet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pet: pet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pet = PetClinicService.get_pet!(id)
    {:ok, _pet} = PetClinicService.delete_pet(pet)

    conn
    |> put_flash(:info, "Pet deleted successfully.")
    |> redirect(to: Routes.pet_path(conn, :index))
  end

  def index_by_type(conn, %{"type" => type}) do
    pet = PetClinicService.list_pets_by_type(type)
    render(conn, "index_by_type.html", pet: pet)
  end

end
