defmodule WinoApi.Wino.Wine do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "wines" do
    field :alcohol, :float
    field :color, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(wine, attrs) do
    wine
    |> cast(attrs, [:name, :color, :alcohol])
    |> validate_required([:name, :color, :alcohol])
  end
end
