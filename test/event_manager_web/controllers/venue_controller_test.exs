defmodule EventManagerWeb.VenueControllerTest do
  use EventManagerWeb.ConnCase

  alias EventManager.Venues.Schemas.Venue

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all venues", %{conn: conn} do
      conn = get(conn, ~p"/api/venues")
      assert json_response(conn, 200)["data"] == []
    end

    test "lists all venues with map links", %{conn: conn} do
      venue = insert(:venue)
      map_link = insert(:map_link, venue: venue)
      conn = get(conn, ~p"/api/venues?maps=true")

      assert [
               %{
                 "id" => venue.id,
                 "name" => venue.name,
                 "address" => venue.address,
                 "map_links" => %{
                   "naver" => map_link.naver_map_link,
                   "t_map" => map_link.t_map_link,
                   "google" => map_link.google_map_link,
                   "kakao" => map_link.kakao_map_link
                 }
               }
             ] == json_response(conn, 200)["data"]
    end
  end

  describe "create venue" do
    test "renders venue when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/venues", venue: %{name: "test venue", address: "test address"})
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/venues/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/venues", venue: %{})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update venue" do
    setup [:create_venue]

    test "renders venue when data is valid", %{conn: conn, venue: %Venue{id: id} = venue} do
      conn =
        put(conn, ~p"/api/venues/#{venue}", venue: %{name: "new venue", address: "new address"})

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/venues/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, venue: venue} do
      conn = put(conn, ~p"/api/venues/#{venue}", venue: %{name: nil, address: nil})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete venue" do
    setup [:create_venue]

    test "deletes chosen venue", %{conn: conn, venue: venue} do
      conn = delete(conn, ~p"/api/venues/#{venue}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/venues/#{venue}")
      end
    end
  end

  defp create_venue(_) do
    venue = insert(:venue)
    %{venue: venue}
  end
end
