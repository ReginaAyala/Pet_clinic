defmodule PetClinic.PetClinicService.Owner do
  @moduledoc """
   This is module Owner.
   the data schema is created for a owner and the related with pet.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "owners" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :phone_num, :string
    has_many :pets, PetClinic.PetClinicService.Pet
    timestamps()
  end

  @doc false
  def changeset(owner, attrs) do
    owner
    |> cast(attrs, [:name, :age, :email, :phone_num])
    |> validate_required([:name, :age, :email, :phone_num])
  end
end
