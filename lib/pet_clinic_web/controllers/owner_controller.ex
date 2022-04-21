defmodule PetClinicWeb.OwnerController do
  use PetClinicWeb, :controller

  alias PetClinic.PetClinicService
  alias PetClinic.PetClinicService.Owner

  def index(conn, _params) do
    owners = PetClinicService.list_owners()
    render(conn, "index.html", owners: owners)
  end

  def new(conn, _params) do
    changeset = PetClinicService.change_owner(%Owner{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"owner" => owner_params}) do
    case PetClinicService.create_owner(owner_params) do
      {:ok, owner} ->
        conn
        |> put_flash(:info, "Owner created successfully.")
        |> redirect(to: Routes.owner_path(conn, :show, owner))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    owner = PetClinicService.get_owner!(id)
    render(conn, "show.html", owner: owner)
  end

  def edit(conn, %{"id" => id}) do
    owner = PetClinicService.get_owner!(id)
    changeset = PetClinicService.change_owner(owner)
    render(conn, "edit.html", owner: owner, changeset: changeset)
  end

  def update(conn, %{"id" => id, "owner" => owner_params}) do
    owner = PetClinicService.get_owner!(id)

    case PetClinicService.update_owner(owner, owner_params) do
      {:ok, owner} ->
        conn
        |> put_flash(:info, "Owner updated successfully.")
        |> redirect(to: Routes.owner_path(conn, :show, owner))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", owner: owner, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    owner = PetClinicService.get_owner!(id)
    {:ok, _owner} = PetClinicService.delete_owner(owner)

    conn
    |> put_flash(:info, "Owner deleted successfully.")
    |> redirect(to: Routes.owner_path(conn, :index))
  end
end
