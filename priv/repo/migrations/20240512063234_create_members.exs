defmodule EventManager.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :username, :string
      add :display_name, :string
      add :email, :string
      add :phone, :string
      add :image_url, :string
      add :short_bio, :string

      timestamps()
    end

    create unique_index(:members, [:username])
    create unique_index(:members, [:email])
  end
end
