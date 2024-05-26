defmodule EventManagerWeb.SeriesJSON do
  alias EventManager.Events.Schemas.Event
  alias EventManager.Events.Schemas.Series

  @doc """
  Renders a list of series.
  """
  def index(%{series: series}) do
    %{data: for(series <- series, do: data(series))}
  end

  @doc """
  Renders a single series.
  """
  def show(%{series: series}) do
    %{data: data(series)}
  end

  def list_events(%{events: events}) do
    %{data: for(event <- events, do: data(event))}
  end

  defp data(%Series{} = series) do
    %{
      id: series.id
    }
  end

  defp data(%Event{} = event) do
    %{
      description: event.description,
      event_id: event.id,
      series_id: event.series_id
    }
  end
end
