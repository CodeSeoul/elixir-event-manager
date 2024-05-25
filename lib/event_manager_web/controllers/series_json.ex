defmodule EventManagerWeb.SeriesJSON do
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

  defp data(%Series{} = series) do
    %{
      id: series.id
    }
  end
end
