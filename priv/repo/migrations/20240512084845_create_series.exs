defmodule EventManager.Repo.Migrations.CreateSeries do
  use Ecto.Migration

  def change do
    create table(:series) do
      add :name, :string

      timestamps()
    end

    alter table(:events) do
      add :series_id, references(:series)
    end
  end
end
