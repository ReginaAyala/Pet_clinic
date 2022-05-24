defmodule PetClinic.PetHealthExpertFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetHealthExpert` context.
  """

  @doc """
  Generate a vet.
  """
  def vet_fixture(attrs \\ %{}) do
    {:ok, vet} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        sex: :female
        # specialities: "some specialities"
      })
      |> PetClinic.PetHealthExpert.create_vet()

    vet
  end
end
