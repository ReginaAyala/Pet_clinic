defmodule PetClinic.PetHealthExpert.Vet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vets" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :sex, :string
    field :specialities, :string
    has_many(:pets, PetClinic.PetClinicService.Pet, foreign_key: :preferred_expert_id)
    timestamps()
  end

  @doc false
  def changeset(vet, attrs) do
    vet
    |> cast(attrs, [:name, :age, :email, :specialities, :sex])
    |> validate_required([:name, :age, :email, :specialities, :sex])
  end
end
