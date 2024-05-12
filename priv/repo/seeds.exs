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
alias EventManager.Members.Schemas.Member
alias EventManager.Venues.Schemas.MapLink
alias EventManager.Venues.Schemas.Venue

# Insert venues

%Venue{id: venue_id} =
  Repo.insert!(%Venue{
    id: "018f683f-3fc6-74f0-8dd4-d0b9db3dd0a0",
    name: "Lunit HQ",
    address: "서울특별시 강남구 강남대로 374 5층"
  })

Repo.insert(%MapLink{
  venue_id: venue_id,
  id: "018f6841-f167-7c64-8146-12490654bd2b",
  naver_map_link: "https://map.naver.com/p/entry/place/43581035?c=15.00,0,0,0,dh",
  google_map_link:
    "https://www.google.com/maps/place/Lunit%E3%85%A3%EB%A3%A8%EB%8B%9B/data=!3m1!4b1!4m6!3m5!1s0x357ca154e47068b5:0x49702de5e963d359!8m2!3d37.4961931!4d127.0288777!16s%2Fg%2F11c6f2005h?entry=ttu"
})

# Insert members

Repo.insert!(%Member{
  id: "018f6b84-9545-7554-a529-ba6a01c6aa73",
  username: "snachez",
  display_name: "Carlos Sanchez",
  email: "carlos+event_manager@sanchez.kr",
  phone: "+82 10-6899-2809"
})

# Insert events

events = [
  %Event{
    id: "018f6845-d4f4-79ce-b1c1-f9a5db2bb0e0",
    description: "Social gathering with other coders",
    starts_at: ~U[2024-05-12 09:00:00Z],
    duration: 120,
    venue_id: "018f683f-3fc6-74f0-8dd4-d0b9db3dd0a0"
  },
  %Event{
    id: "018f6846-f0fc-7a23-9ad8-d66d5dde46c7",
    description: "Social gathering with other coders",
    starts_at: ~U[2024-05-26 09:00:00Z],
    duration: 120,
    venue_id: "018f683f-3fc6-74f0-8dd4-d0b9db3dd0a0"
  }
]

Enum.each(events, &Repo.insert!/1)
