defmodule PetClinicWeb.VetController do
  use PetClinicWeb, :controller

  alias PetClinic.PetHealthExpert
  alias PetClinic.PetHealthExpert.Vet

  def index(conn, _params) do
    vets = PetHealthExpert.list_vets()
    render(conn, "index.html", vets: vets)
  end

  def new(conn, _params) do
    changeset = PetHealthExpert.change_vet(%Vet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"vet" => vet_params}) do
    case PetHealthExpert.create_vet(vet_params) do
      {:ok, vet} ->
        conn
        |> put_flash(:info, "Vet created successfully.")
        |> redirect(to: Routes.vet_path(conn, :show, vet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    vet = PetHealthExpert.get_vet!(id)
    render(conn, "show.html", vet: vet)
  end

  def edit(conn, %{"id" => id}) do
    vet = PetHealthExpert.get_vet!(id)
    changeset = PetHealthExpert.change_vet(vet)
    render(conn, "edit.html", vet: vet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "vet" => vet_params}) do
    vet = PetHealthExpert.get_vet!(id)

    case PetHealthExpert.update_vet(vet, vet_params) do
      {:ok, vet} ->
        conn
        |> put_flash(:info, "Vet updated successfully.")
        |> redirect(to: Routes.vet_path(conn, :show, vet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", vet: vet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    vet = PetHealthExpert.get_vet!(id)
    {:ok, _vet} = PetHealthExpert.delete_vet(vet)

    conn
    |> put_flash(:info, "Vet deleted successfully.")
    |> redirect(to: Routes.vet_path(conn, :index))
  end
end
