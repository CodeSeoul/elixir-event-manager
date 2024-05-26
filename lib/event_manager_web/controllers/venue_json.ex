defmodule EventManagerWeb.VenueJSON do
  alias EventManager.Venues.Schemas.Venue
  alias EventManager.Venues.Schemas.MapLink

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

  defp data(%Venue{map_link: %MapLink{} = map_link} = venue) do
    %{
      id: venue.id,
      name: venue.name,
      address: venue.address,
      map_links: %{
        naver: map_link.naver_map_link,
        t_map: map_link.t_map_link,
        google: map_link.google_map_link,
        kakao: map_link.kakao_map_link
      }
    }
  end

  defp data(%Venue{} = venue) do
    %{
      id: venue.id,
      name: venue.name,
      address: venue.address
    }
  end
end
