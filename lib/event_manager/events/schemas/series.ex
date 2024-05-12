defmodule EventManager.Events.Schemas.Series do
  use EventManager.Schema

  import Ecto.Changeset

  alias EventManager.Events.Schemas.Event

  schema "series" do
    field(:name, :string)
    has_many(:events, Event)

    timestamps()
  end

  def changeset(series, attrs) do
    series
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
