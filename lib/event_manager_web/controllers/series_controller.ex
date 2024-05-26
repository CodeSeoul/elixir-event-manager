defmodule EventManagerWeb.SeriesController do
  use EventManagerWeb, :controller

  alias EventManager.Events
  alias EventManager.Events.Schemas.Series

  action_fallback EventManagerWeb.FallbackController

  def index(conn, _params) do
    series = Events.list_series()
    render(conn, :index, series: series)
  end

  def create(conn, %{"series" => series_params}) do
    with {:ok, %Series{} = series} <- Events.create_series(series_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/series/#{series}")
      |> render(:show, series: series)
    end
  end

  def show(conn, %{"id" => id}) do
    series = Events.get_series!(id)
    render(conn, :show, series: series)
  end

  def update(conn, %{"id" => id, "series" => series_params}) do
    series = Events.get_series!(id)

    with {:ok, %Series{} = series} <- Events.update_series(series, series_params) do
      render(conn, :show, series: series)
    end
  end

  def delete(conn, %{"id" => id}) do
    series = Events.get_series!(id)

    with {:ok, %Series{}} <- Events.delete_series(series) do
      send_resp(conn, :no_content, "")
    end
  end

  def list_events(conn, %{"id" => id}) do
    events = Events.list_series_events(id)
    render(conn, :list_events, events: events)
  end
end
