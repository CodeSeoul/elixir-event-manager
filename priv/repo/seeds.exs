# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EventManager.Repo.insert!(%EventManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias EventManager.Repo

alias EventManager.Events.Schemas.Event
alias EventManager.Events.Schemas.Rsvp
alias EventManager.Events.Schemas.Series
alias EventManager.Members.Schemas.Member
alias EventManager.Venues.Schemas.MapLink
alias EventManager.Venues.Schemas.Venue

# Insert venues

%Venue{id: venue_id} =
  Repo.insert!(%Venue{
    name: "Lunit HQ",
    address: "서울특별시 강남구 강남대로 374 5층"
  })

Repo.insert(%MapLink{
  venue_id: venue_id,
  naver_map_link: "https://map.naver.com/p/entry/place/43581035?c=15.00,0,0,0,dh",
  google_map_link:
    "https://www.google.com/maps/place/Lunit%E3%85%A3%EB%A3%A8%EB%8B%9B/data=!3m1!4b1!4m6!3m5!1s0x357ca154e47068b5:0x49702de5e963d359!8m2!3d37.4961931!4d127.0288777!16s%2Fg%2F11c6f2005h?entry=ttu"
})

# Insert members

%{id: member_id} =
  Repo.insert!(%Member{
    username: "snachez",
    display_name: "Carlos Sanchez",
    email: "carlos+event_manager@codeseoul.org",
    phone: "+82 10-6899-2809"
  })

# Insert events

%{id: series_id} =
  Repo.insert!(%Series{
    name: "SH: Office Hours and Social!"
  })

events = [
  %{
    id: UUIDv7.generate(),
    description: "Social gathering with other coders",
    starts_at: ~U[2024-05-12 09:00:00Z],
    duration: 120,
    venue_id: venue_id,
    series_id: series_id,
    inserted_at: DateTime.utc_now(:second),
    updated_at: DateTime.utc_now(:second)
  },
  %{
    id: UUIDv7.generate(),
    description: "Social gathering with other coders",
    starts_at: ~U[2024-05-26 09:00:00Z],
    duration: 120,
    venue_id: venue_id,
    series_id: series_id,
    inserted_at: DateTime.utc_now(:second),
    updated_at: DateTime.utc_now(:second)
  }
]

{2, [_, event]} = Repo.insert_all(Event, events, returning: true)

# Insert RSVPs

Repo.insert!(%Rsvp{
  status: :yes,
  event_id: event.id,
  member_id: member_id
})
