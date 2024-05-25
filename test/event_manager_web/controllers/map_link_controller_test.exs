defmodule EventManagerWeb.MapLinkControllerTest do
  use EventManagerWeb.ConnCase

  alias EventManager.Venues.Schemas.MapLink

  setup %{conn: conn} do
    venue = insert(:venue)
    [conn: put_req_header(conn, "accept", "application/json"), venue: venue]
  end

  describe "index" do
    test "lists all map_links", %{conn: conn} do
      conn = get(conn, ~p"/api/map_links")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create map_link" do
    test "renders map_link when data is valid", %{conn: conn, venue: venue} do
      conn = post(conn, ~p"/api/map_links", map_link: %{venue_id: venue.id})
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/map_links/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/map_links", map_link: %{})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update map_link" do
    setup [:create_map_link]

    test "renders map_link when data is valid", %{
      conn: conn,
      map_link: %MapLink{id: id} = map_link
    } do
      conn = put(conn, ~p"/api/map_links/#{map_link}", map_link: %{t_map_link: "test link"})
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/map_links/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, map_link: map_link} do
      conn = put(conn, ~p"/api/map_links/#{map_link}", map_link: %{venue_id: nil})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete map_link" do
    setup [:create_map_link]

    test "deletes chosen map_link", %{conn: conn, map_link: map_link} do
      conn = delete(conn, ~p"/api/map_links/#{map_link}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/map_links/#{map_link}")
      end
    end
  end

  defp create_map_link(_) do
    map_link = insert(:map_link)
    %{map_link: map_link}
  end
end
