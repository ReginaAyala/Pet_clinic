defmodule PetClinic.PetClinicServiceTest do
  use PetClinic.DataCase

  alias PetClinic.PetClinicService

  describe "pets" do
    alias PetClinic.PetClinicService.Pet

    import PetClinic.PetClinicServiceFixtures

    @invalid_attrs %{age: nil, name: nil, sex: nil, type: nil}

    test "list_pets/0 returns all pets" do
      pet = pet_fixture()
      assert PetClinicService.list_pets() == [pet]
    end

    test "get_pet!/1 returns the pet with given id" do
      pet = pet_fixture()
      assert PetClinicService.get_pet!(pet.id) == pet
    end

    test "create_pet/1 with valid data creates a pet" do
      valid_attrs = %{age: 42, name: "some name", sex: "some sex", type: "some type"}

      assert {:ok, %Pet{} = pet} = PetClinicService.create_pet(valid_attrs)
      assert pet.age == 42
      assert pet.name == "some name"
      assert pet.sex == "some sex"
      assert pet.type == "some type"
    end

    test "create_pet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetClinicService.create_pet(@invalid_attrs)
    end

    test "update_pet/2 with valid data updates the pet" do
      pet = pet_fixture()
      update_attrs = %{age: 43, name: "some updated name", sex: "some updated sex", type: "some updated type"}

      assert {:ok, %Pet{} = pet} = PetClinicService.update_pet(pet, update_attrs)
      assert pet.age == 43
      assert pet.name == "some updated name"
      assert pet.sex == "some updated sex"
      assert pet.type == "some updated type"
    end

    test "update_pet/2 with invalid data returns error changeset" do
      pet = pet_fixture()
      assert {:error, %Ecto.Changeset{}} = PetClinicService.update_pet(pet, @invalid_attrs)
      assert pet == PetClinicService.get_pet!(pet.id)
    end

    test "delete_pet/1 deletes the pet" do
      pet = pet_fixture()
      assert {:ok, %Pet{}} = PetClinicService.delete_pet(pet)
      assert_raise Ecto.NoResultsError, fn -> PetClinicService.get_pet!(pet.id) end
    end

    test "change_pet/1 returns a pet changeset" do
      pet = pet_fixture()
      assert %Ecto.Changeset{} = PetClinicService.change_pet(pet)
    end
  end

  describe "owners" do
    alias PetClinic.PetClinicService.Owner

    import PetClinic.PetClinicServiceFixtures

    @invalid_attrs %{age: nil, email: nil, name: nil, phone_num: nil}

    test "list_owners/0 returns all owners" do
      owner = owner_fixture()
      assert PetClinicService.list_owners() == [owner]
    end

    test "get_owner!/1 returns the owner with given id" do
      owner = owner_fixture()
      assert PetClinicService.get_owner!(owner.id) == owner
    end

    test "create_owner/1 with valid data creates a owner" do
      valid_attrs = %{age: 42, email: "some email", name: "some name", phone_num: "some phone_num"}

      assert {:ok, %Owner{} = owner} = PetClinicService.create_owner(valid_attrs)
      assert owner.age == 42
      assert owner.email == "some email"
      assert owner.name == "some name"
      assert owner.phone_num == "some phone_num"
    end

    test "create_owner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetClinicService.create_owner(@invalid_attrs)
    end

    test "update_owner/2 with valid data updates the owner" do
      owner = owner_fixture()
      update_attrs = %{age: 43, email: "some updated email", name: "some updated name", phone_num: "some updated phone_num"}

      assert {:ok, %Owner{} = owner} = PetClinicService.update_owner(owner, update_attrs)
      assert owner.age == 43
      assert owner.email == "some updated email"
      assert owner.name == "some updated name"
      assert owner.phone_num == "some updated phone_num"
    end

    test "update_owner/2 with invalid data returns error changeset" do
      owner = owner_fixture()
      assert {:error, %Ecto.Changeset{}} = PetClinicService.update_owner(owner, @invalid_attrs)
      assert owner == PetClinicService.get_owner!(owner.id)
    end

    test "delete_owner/1 deletes the owner" do
      owner = owner_fixture()
      assert {:ok, %Owner{}} = PetClinicService.delete_owner(owner)
      assert_raise Ecto.NoResultsError, fn -> PetClinicService.get_owner!(owner.id) end
    end

    test "change_owner/1 returns a owner changeset" do
      owner = owner_fixture()
      assert %Ecto.Changeset{} = PetClinicService.change_owner(owner)
    end
  end
end
