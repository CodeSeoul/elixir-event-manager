defmodule EventManager.Venues.Schemas.MapLink do
  use EventManager.Schema

  import Ecto.Changeset

  alias EventManager.Venues.Schemas.Venue

  schema "map_links" do
    field(:naver_map_link, :string)
    field(:t_map_link, :string)
    field(:google_map_link, :string)
    field(:kakao_map_link, :string)
    belongs_to(:venue, Venue)

    timestamps()
  end

  def changeset(%__MODULE__{} = map_link, attrs) do
    map_link
    |> cast(attrs, [:naver_map_link, :t_map_link, :google_map_link, :kakao_map_link, :venue_id])
    |> validate_required([:venue_id])
  end
end
