defmodule EventManager.Events.Schemas.Event do
  use EventManager.Schema
  import Ecto.Changeset

  alias EventManager.Venues.Schemas.Venue

  schema "events" do
    field(:description, :string)
    field(:starts_at, :utc_datetime)
    field(:duration, :integer)
    field(:image_url, :string)
    belongs_to(:venue, Venue)
    field(:online_link, :string)

    timestamps()
  end

  def changeset(event, attrs) do
    event
    |> cast(attrs, [:description, :starts_at, :duration, :image_url, :venue_id, :online_link])
    |> validate_required([:description, :starts_at, :duration, :venue_id])
  end
end
