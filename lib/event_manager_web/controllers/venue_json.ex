defmodule EventManagerWeb.VenueJSON do
  alias EventManager.Venues.Schemas.Venue

  @doc """
  Renders a list of venues.
  """
  def index(%{venues: venues}) do
    %{data: for(venue <- venues, do: data(venue))}
  end

  @doc """
  Renders a single venue.
  """
  def show(%{venue: venue}) do
    %{data: data(venue)}
  end

  defp data(%Venue{} = venue) do
    %{
      id: venue.id
    }
  end
end
