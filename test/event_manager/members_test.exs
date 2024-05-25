defmodule EventManager.MembersTest do
  use EventManager.DataCase

  alias EventManager.Members
  alias EventManager.Members.Schemas.Member

  describe "members" do
    @invalid_attrs %{}

    test "list_members/0 returns all members" do
      member = insert(:member)
      assert Members.list_members() == [member]
    end

    test "get_member!/1 returns the member with given id" do
      member = insert(:member)
      assert Members.get_member!(member.id) == member
    end

    test "create_member/1 with valid data creates a member" do
      valid_attrs = %{
        username: "test username",
        display_name: "test display name",
        email: "test-user@codeseoul.org"
      }

      assert {:ok, %Member{}} = Members.create_member(valid_attrs)
    end

    test "create_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Members.create_member(@invalid_attrs)
    end

    test "update_member/2 with valid data updates the member" do
      member = insert(:member)
      update_attrs = %{}

      assert {:ok, %Member{}} = Members.update_member(member, update_attrs)
    end

    test "update_member/2 with invalid data returns error changeset" do
      member = insert(:member)

      assert {:error, %Ecto.Changeset{}} =
               Members.update_member(member, %{email: "invalid-email"})

      assert member == Members.get_member!(member.id)
    end

    test "delete_member/1 deletes the member" do
      member = insert(:member)
      assert {:ok, %Member{}} = Members.delete_member(member)
      assert_raise Ecto.NoResultsError, fn -> Members.get_member!(member.id) end
    end

    test "change_member/1 returns a member changeset" do
      member = insert(:member)
      assert %Ecto.Changeset{} = Members.change_member(member)
    end
  end
end
