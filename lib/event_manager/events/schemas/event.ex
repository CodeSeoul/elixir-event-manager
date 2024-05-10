defmodule EventManager.Events.Schemas.Event do
  use EventManager.Schema
  import Ecto.Changeset

  schema "events" do
    field(:description, :string)
    field(:starts_at, :utc_datetime)
    field(:duration, :integer)
    field(:image_url, :string)
    field(:venue, :string)
    field(:online_link, :string)

    timestamps()
  end

  def changeset(event, attrs) do
    event
    |> cast(attrs, [:description, :starts_at, :duration, :image_url, :venue, :online_link])
    |> validate_required([:description, :starts_at, :duration, :venue])
  end
end
