defmodule EventManagerWeb.MapLinkController do
  use EventManagerWeb, :controller

  alias EventManager.Venues
  alias EventManager.Venues.Schemas.MapLink

  action_fallback EventManagerWeb.FallbackController

  def index(conn, _params) do
    map_links = Venues.list_map_links()
    render(conn, :index, map_links: map_links)
  end

  def create(conn, %{"map_link" => map_link_params}) do
    with {:ok, %MapLink{} = map_link} <- Venues.create_map_link(map_link_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/map_links/#{map_link}")
      |> render(:show, map_link: map_link)
    end
  end

  def show(conn, %{"id" => id}) do
    map_link = Venues.get_map_link!(id)
    render(conn, :show, map_link: map_link)
  end

  def update(conn, %{"id" => id, "map_link" => map_link_params}) do
    map_link = Venues.get_map_link!(id)

    with {:ok, %MapLink{} = map_link} <- Venues.update_map_link(map_link, map_link_params) do
      render(conn, :show, map_link: map_link)
    end
  end

  def delete(conn, %{"id" => id}) do
    map_link = Venues.get_map_link!(id)

    with {:ok, %MapLink{}} <- Venues.delete_map_link(map_link) do
      send_resp(conn, :no_content, "")
    end
  end
end
