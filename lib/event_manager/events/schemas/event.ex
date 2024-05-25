defmodule EventManager.Events.Schemas.Event do
  use EventManager.Schema
  import Ecto.Changeset

  alias EventManager.Events.Schemas.Rsvp
  alias EventManager.Events.Schemas.Series
  alias EventManager.Venues.Schemas.Venue

  schema "events" do
    field(:description, :string)
    field(:starts_at, :utc_datetime)
    field(:duration, :integer)
    field(:image_url, :string)
    field(:online_link, :string)

    belongs_to(:venue, Venue)
    belongs_to(:series, Series)

    has_many(:rsvps, Rsvp)

    timestamps()
  end

  def changeset(event, attrs) do
    event
    |> cast(attrs, [
      :description,
      :starts_at,
      :duration,
      :image_url,
      :venue_id,
      :series_id,
      :online_link
    ])
    |> validate_required([:description, :starts_at, :duration, :venue_id, :series_id])
  end
end
