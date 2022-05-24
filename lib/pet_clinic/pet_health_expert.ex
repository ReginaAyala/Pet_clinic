defmodule PetClinic.PetHealthExpert do
  @moduledoc """
  The PetHealthExpert context.
  """

  import Ecto.Query, warn: false
  alias PetClinic.Repo

  alias PetClinic.PetHealthExpert.Vet

  @doc """
  Returns the list of vets.

  ## Examples

      iex> list_vets()
      [%Vet{}, ...]

  """
  def list_vets do
    # |> Repo.preload(:specialities)
    Repo.all(Vet)
  end

  def list_vets(assoc) do
    Repo.all(Vet) |> Repo.preload(assoc)
  end

  @doc """
  Gets a single vet.

  Raises `Ecto.NoResultsError` if the Vet does not exist.

  ## Examples

      iex> get_vet!(123)
      %Vet{}

      iex> get_vet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vet!(id), do: Repo.get!(Vet, id)
  def get_vet!(id, assoc), do: Repo.get!(Vet, id) |> Repo.preload(assoc)

  @doc """
  Creates a vet.

  ## Examples

      iex> create_vet(%{field: value})
      {:ok, %Vet{}}

      iex> create_vet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vet(attrs \\ %{}) do
    %Vet{}
    |> Vet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vet.

  ## Examples

      iex> update_vet(vet, %{field: new_value})
      {:ok, %Vet{}}

      iex> update_vet(vet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vet(%Vet{} = vet, attrs) do
    vet
    |> Vet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vet.

  ## Examples

      iex> delete_vet(vet)
      {:ok, %Vet{}}

      iex> delete_vet(vet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vet(%Vet{} = vet) do
    Repo.delete(vet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vet changes.

  ## Examples

      iex> change_vet(vet)
      %Ecto.Changeset{data: %Vet{}}

  """
  def change_vet(%Vet{} = vet, attrs \\ %{}) do
    Vet.changeset(vet, attrs)
  end
end
