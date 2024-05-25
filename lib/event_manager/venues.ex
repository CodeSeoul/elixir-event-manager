defmodule EventManager.Venues do
  @moduledoc """
  The Venues context.
  """

  import Ecto.Query, warn: false
  alias EventManager.Repo

  alias EventManager.Venues.Schemas.MapLink

  @doc """
  Returns the list of map_links.

  ## Examples

      iex> list_map_links()
      [%MapLink{}, ...]

  """
  def list_map_links do
    Repo.all(MapLink)
  end

  @doc """
  Gets a single map_link.

  Raises `Ecto.NoResultsError` if the Map link does not exist.

  ## Examples

      iex> get_map_link!(123)
      %MapLink{}

      iex> get_map_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_map_link!(id), do: Repo.get!(MapLink, id)

  @doc """
  Creates a map_link.

  ## Examples

      iex> create_map_link(%{field: value})
      {:ok, %MapLink{}}

      iex> create_map_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_map_link(attrs \\ %{}) do
    %MapLink{}
    |> MapLink.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a map_link.

  ## Examples

      iex> update_map_link(map_link, %{field: new_value})
      {:ok, %MapLink{}}

      iex> update_map_link(map_link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_map_link(%MapLink{} = map_link, attrs) do
    map_link
    |> MapLink.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a map_link.

  ## Examples

      iex> delete_map_link(map_link)
      {:ok, %MapLink{}}

      iex> delete_map_link(map_link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_map_link(%MapLink{} = map_link) do
    Repo.delete(map_link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking map_link changes.

  ## Examples

      iex> change_map_link(map_link)
      %Ecto.Changeset{data: %MapLink{}}

  """
  def change_map_link(%MapLink{} = map_link, attrs \\ %{}) do
    MapLink.changeset(map_link, attrs)
  end

  alias EventManager.Venues.Schemas.Venue

  @doc """
  Returns the list of venues.

  ## Examples

      iex> list_venues()
      [%Venue{}, ...]

  """
  def list_venues do
    Repo.all(Venue)
  end

  @doc """
  Gets a single venue.

  Raises `Ecto.NoResultsError` if the Venue does not exist.

  ## Examples

      iex> get_venue!(123)
      %Venue{}

      iex> get_venue!(456)
      ** (Ecto.NoResultsError)

  """
  def get_venue!(id), do: Repo.get!(Venue, id)

  @doc """
  Creates a venue.

  ## Examples

      iex> create_venue(%{field: value})
      {:ok, %Venue{}}

      iex> create_venue(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_venue(attrs \\ %{}) do
    %Venue{}
    |> Venue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a venue.

  ## Examples

      iex> update_venue(venue, %{field: new_value})
      {:ok, %Venue{}}

      iex> update_venue(venue, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_venue(%Venue{} = venue, attrs) do
    venue
    |> Venue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a venue.

  ## Examples

      iex> delete_venue(venue)
      {:ok, %Venue{}}

      iex> delete_venue(venue)
      {:error, %Ecto.Changeset{}}

  """
  def delete_venue(%Venue{} = venue) do
    Repo.delete(venue)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking venue changes.

  ## Examples

      iex> change_venue(venue)
      %Ecto.Changeset{data: %Venue{}}

  """
  def change_venue(%Venue{} = venue, attrs \\ %{}) do
    Venue.changeset(venue, attrs)
  end
end
