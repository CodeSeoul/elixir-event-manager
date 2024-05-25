defmodule EventManagerWeb.MemberControllerTest do
  use EventManagerWeb.ConnCase

  alias EventManager.Members.Schemas.Member

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all members", %{conn: conn} do
      conn = get(conn, ~p"/api/members")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create member" do
    test "renders member when data is valid", %{conn: conn} do
      conn =
        post(conn, ~p"/api/members",
          member: %{
            username: "test",
            display_name: "Test User",
            email: "test@codeseoul.org"
          }
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/members/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/members", member: %{})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update member" do
    setup [:create_member]

    test "renders member when data is valid", %{conn: conn, member: %Member{id: id} = member} do
      conn = put(conn, ~p"/api/members/#{member}", member: %{phone: "1234567890"})
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/members/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, member: member} do
      conn = put(conn, ~p"/api/members/#{member}", member: %{email: "invalid-email"})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete member" do
    setup [:create_member]

    test "deletes chosen member", %{conn: conn, member: member} do
      conn = delete(conn, ~p"/api/members/#{member}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/members/#{member}")
      end
    end
  end

  defp create_member(_) do
    member = insert(:member)
    %{member: member}
  end
end
