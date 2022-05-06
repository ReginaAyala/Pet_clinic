defmodule PetClinic.PetHealthExpertTest do
  use PetClinic.DataCase

  alias PetClinic.PetHealthExpert

  describe "vets" do
    alias PetClinic.PetHealthExpert.Vet

    import PetClinic.PetHealthExpertFixtures

    @invalid_attrs %{age: nil, email: nil, name: nil, sex: nil, specialities: nil}

    test "list_vets/0 returns all vets" do
      vet = vet_fixture()
      assert PetHealthExpert.list_vets() == [vet]
    end

    test "get_vet!/1 returns the vet with given id" do
      vet = vet_fixture()
      assert PetHealthExpert.get_vet!(vet.id) == vet
    end

    test "create_vet/1 with valid data creates a vet" do
      valid_attrs = %{
        age: 42,
        email: "some email",
        name: "some name",
        sex: "some sex",
        specialities: "some specialities"
      }

      assert {:ok, %Vet{} = vet} = PetHealthExpert.create_vet(valid_attrs)
      assert vet.age == 42
      assert vet.email == "some email"
      assert vet.name == "some name"
      assert vet.sex == "some sex"
      assert vet.specialities == "some specialities"
    end

    test "create_vet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetHealthExpert.create_vet(@invalid_attrs)
    end

    test "update_vet/2 with valid data updates the vet" do
      vet = vet_fixture()

      update_attrs = %{
        age: 43,
        email: "some updated email",
        name: "some updated name",
        sex: "some updated sex",
        specialities: "some updated specialities"
      }

      assert {:ok, %Vet{} = vet} = PetHealthExpert.update_vet(vet, update_attrs)
      assert vet.age == 43
      assert vet.email == "some updated email"
      assert vet.name == "some updated name"
      assert vet.sex == "some updated sex"
      assert vet.specialities == "some updated specialities"
    end

    test "update_vet/2 with invalid data returns error changeset" do
      vet = vet_fixture()
      assert {:error, %Ecto.Changeset{}} = PetHealthExpert.update_vet(vet, @invalid_attrs)
      assert vet == PetHealthExpert.get_vet!(vet.id)
    end

    test "delete_vet/1 deletes the vet" do
      vet = vet_fixture()
      assert {:ok, %Vet{}} = PetHealthExpert.delete_vet(vet)
      assert_raise Ecto.NoResultsError, fn -> PetHealthExpert.get_vet!(vet.id) end
    end

    test "change_vet/1 returns a vet changeset" do
      vet = vet_fixture()
      assert %Ecto.Changeset{} = PetHealthExpert.change_vet(vet)
    end
  end
end
