defmodule EventManager.Repo.Migrations.AddVenueRelationshipToEvent do
  use Ecto.Migration

  def change do
    alter table("events") do
      add :venue_id, references(:venues)
      remove :venue
    end
  end
end
