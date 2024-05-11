defmodule EventManager.Venues.Schemas.Venue do
  use EventManager.Schema

  import Ecto.Changeset

  alias EventManager.Events.Schemas.Event
  alias EventManager.Venues.Schemas.MapLink

  schema "venues" do
    field(:name, :string)
    field(:address, :string)
    has_one(:map_link, MapLink)
    has_many(:events, Event)

    timestamps()
  end

  def changeset(%__MODULE__{} = venue, attrs) do
    venue
    |> cast(attrs, [:name, :address])
    |> validate_required([:name, :address])
  end
end
