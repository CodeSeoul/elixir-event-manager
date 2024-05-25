defmodule EventManagerWeb.SeriesControllerTest do
  use EventManagerWeb.ConnCase

  alias EventManager.Events.Schemas.Series

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all series", %{conn: conn} do
      conn = get(conn, ~p"/api/series")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create series" do
    test "renders series when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/series", series: %{name: "test series"})
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/series/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/series", series: %{})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update series" do
    setup [:create_series]

    test "renders series when data is valid", %{conn: conn, series: %Series{id: id} = series} do
      conn = put(conn, ~p"/api/series/#{series}", series: %{name: "new series"})
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/series/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, series: series} do
      conn = put(conn, ~p"/api/series/#{series}", series: %{name: nil})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete series" do
    setup [:create_series]

    test "deletes chosen series", %{conn: conn, series: series} do
      conn = delete(conn, ~p"/api/series/#{series}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/series/#{series}")
      end
    end
  end

  defp create_series(_) do
    series = insert(:series)
    %{series: series}
  end
end
