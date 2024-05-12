defmodule EventManager.Repo.Migrations.CreateRsvps do
  use Ecto.Migration

  def change do
    create table(:rsvps) do
      add :event_id, references(:events, on_delete: :delete_all)
      add :member_id, references(:members, on_delete: :delete_all)
      add :status, :string

      timestamps()
    end

    create unique_index(:rsvps, [:event_id, :member_id])
  end
end
