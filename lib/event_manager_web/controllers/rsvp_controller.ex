defmodule EventManagerWeb.RsvpController do
  use EventManagerWeb, :controller

  alias EventManager.Events
  alias EventManager.Events.Schemas.Rsvp

  action_fallback EventManagerWeb.FallbackController

  def index(conn, _params) do
    rsvps = Events.list_rsvps()
    render(conn, :index, rsvps: rsvps)
  end

  def create(conn, %{"rsvp" => rsvp_params}) do
    with {:ok, %Rsvp{} = rsvp} <- Events.create_rsvp(rsvp_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/rsvps/#{rsvp}")
      |> render(:show, rsvp: rsvp)
    end
  end

  def show(conn, %{"id" => id}) do
    rsvp = Events.get_rsvp!(id)
    render(conn, :show, rsvp: rsvp)
  end

  def update(conn, %{"id" => id, "rsvp" => rsvp_params}) do
    rsvp = Events.get_rsvp!(id)

    with {:ok, %Rsvp{} = rsvp} <- Events.update_rsvp(rsvp, rsvp_params) do
      render(conn, :show, rsvp: rsvp)
    end
  end

  def delete(conn, %{"id" => id}) do
    rsvp = Events.get_rsvp!(id)

    with {:ok, %Rsvp{}} <- Events.delete_rsvp(rsvp) do
      send_resp(conn, :no_content, "")
    end
  end
end
