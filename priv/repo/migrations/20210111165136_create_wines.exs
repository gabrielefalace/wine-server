defmodule WinoApi.Repo.Migrations.CreateWines do
  use Ecto.Migration

  def change do
    create table(:wines, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :color, :string
      add :alcohol, :float

      timestamps()
    end

  end
end
