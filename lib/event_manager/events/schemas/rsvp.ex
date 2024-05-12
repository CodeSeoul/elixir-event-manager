defmodule EventManager.Events.Schemas.Rsvp do
  use EventManager.Schema

  import Ecto.Changeset

  alias EventManager.Members.Schemas.Member
  alias EventManager.Events.Schemas.Event

  @rsvp_statuses [:yes, :no, :maybe]

  schema "rsvps" do
    field(:status, Ecto.Enum, values: @rsvp_statuses)

    belongs_to(:event, Event)
    belongs_to(:member, Member)

    timestamps()
  end

  def changeset(rsvp, attrs) do
    rsvp
    |> cast(attrs, [:status, :event_id, :member_id])
    |> validate_required([:status, :event_id, :member_id])
    |> validate_inclusion(:status, @rsvp_statuses)
    |> unique_constraint([:event_id, :member_id])
  end
end
