defmodule EventManager.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :description, :string
      add :starts_at, :timestamptz
      add :duration, :integer
      add :image_url, :string
      add :venue, :string
      add :online_link, :string

      timestamps()
    end
  end
end
