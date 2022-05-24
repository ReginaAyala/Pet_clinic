defmodule PetClinic.PetClinicServiceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetClinicService` context.
  """

  @doc """
  Generate a pet.
  """

  alias PetClinic.PetHealthExpertFixtures

  def pet_fixture(attrs \\ %{}) do
    pet_type = type_fixture()
    owner = owner_fixture()
    vet = PetHealthExpertFixtures.vet_fixture()

    {:ok, pet} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name",
        sex: :female,
        type_id: pet_type.id,
        owner_id: owner.id,
        preferred_expert_id: vet.id
      })
      |> PetClinic.PetClinicService.create_pet()

    pet
  end

  def type_fixture(attrs \\ %{}) do
    {:ok, type} =
      attrs
      |> Enum.into(%{
        name_type: "some name"
      })
      |> PetClinic.PetClinicService.create_type()

    type
  end

  @doc """
  Generate a owner.
  """
  def owner_fixture(attrs \\ %{}) do
    {:ok, owner} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        phone_num: "some phone_num"
      })
      |> PetClinic.PetClinicService.create_owner()

    owner
  end
end
