defmodule EventManagerWeb.RsvpControllerTest do
  use EventManagerWeb.ConnCase

  alias EventManager.Events.Schemas.Rsvp

  setup %{conn: conn} do
    event = insert(:event)
    member = insert(:member)

    [
      conn: put_req_header(conn, "accept", "application/json"),
      event: event,
      member: member
    ]
  end

  describe "index" do
    test "lists all rsvps", %{conn: conn} do
      conn = get(conn, ~p"/api/rsvps")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create rsvp" do
    test "renders rsvp when data is valid", %{conn: conn, event: event, member: member} do
      conn =
        post(conn, ~p"/api/rsvps",
          rsvp: %{
            status: "yes",
            event_id: event.id,
            member_id: member.id
          }
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/rsvps/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/rsvps", rsvp: %{})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update rsvp" do
    setup [:create_rsvp]

    test "renders rsvp when data is valid", %{conn: conn, rsvp: %Rsvp{id: id} = rsvp} do
      conn = put(conn, ~p"/api/rsvps/#{rsvp}", rsvp: %{status: "no"})
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/rsvps/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, rsvp: rsvp} do
      conn = put(conn, ~p"/api/rsvps/#{rsvp}", rsvp: %{status: "perhaps"})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete rsvp" do
    setup [:create_rsvp]

    test "deletes chosen rsvp", %{conn: conn, rsvp: rsvp} do
      conn = delete(conn, ~p"/api/rsvps/#{rsvp}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/rsvps/#{rsvp}")
      end
    end
  end

  defp create_rsvp(_) do
    rsvp = insert(:rsvp)
    %{rsvp: rsvp}
  end
end
