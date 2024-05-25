defmodule EventManagerWeb.RsvpJSON do
  alias EventManager.Events.Schemas.Rsvp

  @doc """
  Renders a list of rsvps.
  """
  def index(%{rsvps: rsvps}) do
    %{data: for(rsvp <- rsvps, do: data(rsvp))}
  end

  @doc """
  Renders a single rsvp.
  """
  def show(%{rsvp: rsvp}) do
    %{data: data(rsvp)}
  end

  defp data(%Rsvp{} = rsvp) do
    %{
      id: rsvp.id
    }
  end
end
