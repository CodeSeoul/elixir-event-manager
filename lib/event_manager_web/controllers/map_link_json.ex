defmodule EventManagerWeb.MapLinkJSON do
  alias EventManager.Venues.Schemas.MapLink

  @doc """
  Renders a list of map_links.
  """
  def index(%{map_links: map_links}) do
    %{data: for(map_link <- map_links, do: data(map_link))}
  end

  @doc """
  Renders a single map_link.
  """
  def show(%{map_link: map_link}) do
    %{data: data(map_link)}
  end

  defp data(%MapLink{} = map_link) do
    %{
      id: map_link.id
    }
  end
end
