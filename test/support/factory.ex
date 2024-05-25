defmodule EventManager.Factory do
  use ExMachina.Ecto, repo: EventManager.Repo

  alias EventManager.Events.Schemas.Event
  alias EventManager.Events.Schemas.Rsvp
  alias EventManager.Events.Schemas.Series
  alias EventManager.Members.Schemas.Member
  alias EventManager.Venues.Schemas.MapLink
  alias EventManager.Venues.Schemas.Venue

  def map_link_factory(attrs \\ %{}) do
    {venue, attrs} = Map.pop_lazy(attrs, :venue, fn -> build(:venue) end)

    %MapLink{
      naver_map_link: "https://naver.com",
      t_map_link: "https://t.com",
      google_map_link: "https://google.com",
      kakao_map_link: "https://kakao.com",
      venue: venue
    }
    |> merge_attributes(attrs)
  end

  def venue_factory(attrs \\ %{}) do
    venue = %Venue{
      name: "test venue",
      address: "123 Test St"
    }

    venue
    |> merge_attributes(attrs)
  end

  def member_factory(attrs \\ %{}) do
    member = %Member{
      username: sequence("test username"),
      display_name: "test display name",
      email: sequence(:email, &"test-user-#{&1}@codeseoul.org")
    }

    member
    |> merge_attributes(attrs)
  end

  def rsvp_factory(attrs \\ %{}) do
    {event, attrs} = Map.pop_lazy(attrs, :event, fn -> build(:event) end)
    {member, attrs} = Map.pop_lazy(attrs, :member, fn -> build(:member) end)

    rsvp = %Rsvp{
      status: :yes,
      event: event,
      member: member
    }

    rsvp
    |> merge_attributes(attrs)
  end

  def series_factory(attrs \\ %{}) do
    series = %Series{
      name: "test series"
    }

    series
    |> merge_attributes(attrs)
  end

  def event_factory(attrs \\ %{}) do
    {venue, attrs} = Map.pop_lazy(attrs, :venue, fn -> build(:venue) end)
    {series, attrs} = Map.pop_lazy(attrs, :series, fn -> build(:series) end)

    merge_attributes(
      %Event{
        description: "test event",
        starts_at: ~U[2021-01-01 00:00:00Z],
        duration: 60,
        venue: venue,
        series: series
      },
      attrs
    )
  end
end
