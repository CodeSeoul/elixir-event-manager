defmodule EventManager.VenuesTest do
  use EventManager.DataCase

  alias EventManager.Venues
  alias EventManager.Venues.Schemas.MapLink
  alias EventManager.Venues.Schemas.Venue

  describe "map_links" do
    test "list_map_links/0 returns all map_links" do
      map_link =
        insert(:map_link)
        |> Ecto.reset_fields([:venue])

      assert Venues.list_map_links() == [map_link]
    end

    test "get_map_link!/1 returns the map_link with given id" do
      map_link =
        insert(:map_link)
        |> Ecto.reset_fields([:venue])

      assert Venues.get_map_link!(map_link.id) == map_link
    end

    test "create_map_link/1 with valid data creates a map_link" do
      valid_attrs = %{
        venue_id: insert(:venue).id
      }

      assert {:ok, %MapLink{}} = Venues.create_map_link(valid_attrs)
    end

    test "create_map_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Venues.create_map_link(%{})
    end

    test "update_map_link/2 with valid data updates the map_link" do
      map_link = insert(:map_link)
      update_attrs = %{}

      assert {:ok, %MapLink{}} = Venues.update_map_link(map_link, update_attrs)
    end

    test "update_map_link/2 with invalid data returns error changeset" do
      map_link =
        insert(:map_link)
        |> Ecto.reset_fields([:venue])

      assert {:error, %Ecto.Changeset{}} = Venues.update_map_link(map_link, %{venue_id: nil})
      assert map_link == Venues.get_map_link!(map_link.id)
    end

    test "delete_map_link/1 deletes the map_link" do
      map_link = insert(:map_link)
      assert {:ok, %MapLink{}} = Venues.delete_map_link(map_link)
      assert_raise Ecto.NoResultsError, fn -> Venues.get_map_link!(map_link.id) end
    end

    test "change_map_link/1 returns a map_link changeset" do
      map_link = insert(:map_link)
      assert %Ecto.Changeset{} = Venues.change_map_link(map_link)
    end
  end

  describe "venues" do
    test "list_venues/0 returns all venues" do
      venue = insert(:venue)
      assert Venues.list_venues() == [venue]
    end

    test "get_venue!/1 returns the venue with given id" do
      venue = insert(:venue)
      assert Venues.get_venue!(venue.id) == venue
    end

    test "create_venue/1 with valid data creates a venue" do
      valid_attrs = %{
        name: "Venue",
        address: "Address"
      }

      assert {:ok, %Venue{}} = Venues.create_venue(valid_attrs)
    end

    test "create_venue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Venues.create_venue(%{})
    end

    test "update_venue/2 with valid data updates the venue" do
      venue = insert(:venue)
      update_attrs = %{}

      assert {:ok, %Venue{}} = Venues.update_venue(venue, update_attrs)
    end

    test "update_venue/2 with invalid data returns error changeset" do
      venue = insert(:venue)

      assert {:error, %Ecto.Changeset{}} = Venues.update_venue(venue, %{name: nil})
      assert venue == Venues.get_venue!(venue.id)
    end

    test "delete_venue/1 deletes the venue" do
      venue = insert(:venue)
      assert {:ok, %Venue{}} = Venues.delete_venue(venue)
      assert_raise Ecto.NoResultsError, fn -> Venues.get_venue!(venue.id) end
    end

    test "change_venue/1 returns a venue changeset" do
      venue = insert(:venue)
      assert %Ecto.Changeset{} = Venues.change_venue(venue)
    end
  end
end
