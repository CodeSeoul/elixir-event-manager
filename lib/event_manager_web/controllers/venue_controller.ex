defmodule EventManagerWeb.VenueController do
  use EventManagerWeb, :controller

  alias EventManager.Venues
  alias EventManager.Venues.Schemas.Venue

  action_fallback EventManagerWeb.FallbackController

  def index(conn, _params) do
    venues = Venues.list_venues()
    render(conn, :index, venues: venues)
  end

  def create(conn, %{"venue" => venue_params}) do
    with {:ok, %Venue{} = venue} <- Venues.create_venue(venue_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/venues/#{venue}")
      |> render(:show, venue: venue)
    end
  end

  def show(conn, %{"id" => id}) do
    venue = Venues.get_venue!(id)
    render(conn, :show, venue: venue)
  end

  def update(conn, %{"id" => id, "venue" => venue_params}) do
    venue = Venues.get_venue!(id)

    with {:ok, %Venue{} = venue} <- Venues.update_venue(venue, venue_params) do
      render(conn, :show, venue: venue)
    end
  end

  def delete(conn, %{"id" => id}) do
    venue = Venues.get_venue!(id)

    with {:ok, %Venue{}} <- Venues.delete_venue(venue) do
      send_resp(conn, :no_content, "")
    end
  end
end
