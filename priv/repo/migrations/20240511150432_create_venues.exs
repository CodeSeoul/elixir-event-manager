defmodule EventManager.Repo.Migrations.CreateVenues do
  use Ecto.Migration

  def change do
    create table(:venues) do
      add :name, :string
      add :address, :string

      timestamps()
    end

    create index(:venues, [:name])
  end
end
