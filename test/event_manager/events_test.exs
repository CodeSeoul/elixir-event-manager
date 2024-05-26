defmodule EventManager.EventsTest do
  use EventManager.DataCase

  alias EventManager.Events
  alias EventManager.Events.Schemas.Event
  alias EventManager.Events.Schemas.Rsvp
  alias EventManager.Events.Schemas.Series

  describe "events" do
    test "list_events/0 returns all events" do
      event =
        insert(:event)
        |> Ecto.reset_fields([:venue, :series])

      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event =
        insert(:event)
        |> Ecto.reset_fields([:venue, :series])

      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{
        description: "Test Event",
        starts_at: ~U[2021-01-01 12:00:00Z],
        duration: 60,
        venue_id: insert(:venue).id,
        series_id: insert(:series).id
      }

      assert {:ok, %Event{}} = Events.create_event(valid_attrs)
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(%{})
    end

    test "update_event/2 with valid data updates the event" do
      event = insert(:event)
      update_attrs = %{description: "Updated Event"}

      assert {:ok, %Event{description: "Updated Event"}} =
               Events.update_event(event, update_attrs)
    end

    test "update_event/2 with invalid data returns error changeset" do
      event =
        insert(:event)
        |> Ecto.reset_fields([:venue, :series])

      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, %{description: nil})
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = insert(:event)
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = insert(:event)
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end

  describe "rsvps" do
    test "list_rsvps/0 returns all rsvps" do
      rsvp =
        insert(:rsvp)
        |> Ecto.reset_fields([:event, :member])

      assert Events.list_rsvps() == [rsvp]
    end

    test "get_rsvp!/1 returns the rsvp with given id" do
      rsvp =
        insert(:rsvp)
        |> Ecto.reset_fields([:event, :member])

      assert Events.get_rsvp!(rsvp.id) == rsvp
    end

    test "create_rsvp/1 with valid data creates a rsvp" do
      event = insert(:event)
      member = insert(:member)

      valid_attrs = %{
        status: :yes,
        event_id: event.id,
        member_id: member.id
      }

      assert {:ok, %Rsvp{}} = Events.create_rsvp(valid_attrs)
    end

    test "create_rsvp/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_rsvp(%{})
    end

    test "update_rsvp/2 with valid data updates the rsvp" do
      rsvp = insert(:rsvp)

      update_attrs = %{
        status: :no
      }

      assert {:ok, %Rsvp{}} = Events.update_rsvp(rsvp, update_attrs)
    end

    test "update_rsvp/2 with invalid data returns error changeset" do
      rsvp =
        insert(:rsvp)
        |> Ecto.reset_fields([:event, :member])

      assert {:error, %Ecto.Changeset{}} = Events.update_rsvp(rsvp, %{status: :perhaps})
      assert rsvp == Events.get_rsvp!(rsvp.id)
    end

    test "delete_rsvp/1 deletes the rsvp" do
      rsvp = insert(:rsvp)
      assert {:ok, %Rsvp{}} = Events.delete_rsvp(rsvp)
      assert_raise Ecto.NoResultsError, fn -> Events.get_rsvp!(rsvp.id) end
    end

    test "change_rsvp/1 returns a rsvp changeset" do
      rsvp = insert(:rsvp)
      assert %Ecto.Changeset{} = Events.change_rsvp(rsvp)
    end
  end

  describe "series" do
    test "list_series/0 returns all series" do
      series = insert(:series)
      assert Events.list_series() == [series]
    end

    test "get_series!/1 returns the series with given id" do
      series = insert(:series)
      assert Events.get_series!(series.id) == series
    end

    test "create_series/1 with valid data creates a series" do
      valid_attrs = %{
        name: "Test Series"
      }

      assert {:ok, %Series{}} = Events.create_series(valid_attrs)
    end

    test "create_series/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_series(%{})
    end

    test "update_series/2 with valid data updates the series" do
      series = insert(:series)
      update_attrs = %{}

      assert {:ok, %Series{}} = Events.update_series(series, update_attrs)
    end

    test "update_series/2 with invalid data returns error changeset" do
      series = insert(:series)
      assert {:error, %Ecto.Changeset{}} = Events.update_series(series, %{name: nil})
      assert series == Events.get_series!(series.id)
    end

    test "delete_series/1 deletes the series" do
      series = insert(:series)
      assert {:ok, %Series{}} = Events.delete_series(series)
      assert_raise Ecto.NoResultsError, fn -> Events.get_series!(series.id) end
    end

    test "change_series/1 returns a series changeset" do
      series = insert(:series)
      assert %Ecto.Changeset{} = Events.change_series(series)
    end

    test "list_series_events/1 returns all events for a series" do
      series = insert(:series)

      events =
        insert_list(3, :event, series: series)
        |> Enum.map(&Ecto.reset_fields(&1, [:venue, :series]))

      assert Events.list_series_events(series.id) == events
    end
  end
end
