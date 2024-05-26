defmodule EventManager.Events do
  alias EventManager.Events.Schemas.Event

  alias EventManager.Repo

  import Ecto.Query

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{data: %Event{}}

  """
  def change_event(%Event{} = event, attrs \\ %{}) do
    Event.changeset(event, attrs)
  end

  alias EventManager.Events.Schemas.Rsvp

  @doc """
  Returns the list of rsvps.

  ## Examples

      iex> list_rsvps()
      [%Rsvp{}, ...]

  """
  def list_rsvps do
    Repo.all(Rsvp)
  end

  @doc """
  Gets a single rsvp.

  Raises `Ecto.NoResultsError` if the Rsvp does not exist.

  ## Examples

      iex> get_rsvp!(123)
      %Rsvp{}

      iex> get_rsvp!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rsvp!(id), do: Repo.get!(Rsvp, id)

  @doc """
  Creates a rsvp.

  ## Examples

      iex> create_rsvp(%{field: value})
      {:ok, %Rsvp{}}

      iex> create_rsvp(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rsvp(attrs \\ %{}) do
    %Rsvp{}
    |> Rsvp.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rsvp.

  ## Examples

      iex> update_rsvp(rsvp, %{field: new_value})
      {:ok, %Rsvp{}}

      iex> update_rsvp(rsvp, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rsvp(%Rsvp{} = rsvp, attrs) do
    rsvp
    |> Rsvp.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rsvp.

  ## Examples

      iex> delete_rsvp(rsvp)
      {:ok, %Rsvp{}}

      iex> delete_rsvp(rsvp)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rsvp(%Rsvp{} = rsvp) do
    Repo.delete(rsvp)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rsvp changes.

  ## Examples

      iex> change_rsvp(rsvp)
      %Ecto.Changeset{data: %Rsvp{}}

  """
  def change_rsvp(%Rsvp{} = rsvp, attrs \\ %{}) do
    Rsvp.changeset(rsvp, attrs)
  end

  alias EventManager.Events.Schemas.Series

  @doc """
  Returns the list of series.

  ## Examples

      iex> list_series()
      [%Series{}, ...]

  """
  def list_series do
    Repo.all(Series)
  end

  @doc """
  Gets a single series.

  Raises `Ecto.NoResultsError` if the Series does not exist.

  ## Examples

      iex> get_series!(123)
      %Series{}

      iex> get_series!(456)
      ** (Ecto.NoResultsError)

  """
  def get_series!(id), do: Repo.get!(Series, id)

  @doc """
  Creates a series.

  ## Examples

      iex> create_series(%{field: value})
      {:ok, %Series{}}

      iex> create_series(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_series(attrs \\ %{}) do
    %Series{}
    |> Series.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a series.

  ## Examples

      iex> update_series(series, %{field: new_value})
      {:ok, %Series{}}

      iex> update_series(series, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_series(%Series{} = series, attrs) do
    series
    |> Series.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a series.

  ## Examples

      iex> delete_series(series)
      {:ok, %Series{}}

      iex> delete_series(series)
      {:error, %Ecto.Changeset{}}

  """
  def delete_series(%Series{} = series) do
    Repo.delete(series)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking series changes.

  ## Examples

      iex> change_series(series)
      %Ecto.Changeset{data: %Series{}}

  """
  def change_series(%Series{} = series, attrs \\ %{}) do
    Series.changeset(series, attrs)
  end

  def list_series_events(series_id) do
    query =
      from(e in Event,
        where: e.series_id == ^series_id
      )

    Repo.all(query)
  end
end
