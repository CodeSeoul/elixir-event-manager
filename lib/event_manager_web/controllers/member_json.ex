defmodule EventManagerWeb.MemberJSON do
  alias EventManager.Members.Schemas.Member

  @doc """
  Renders a list of members.
  """
  def index(%{members: members}) do
    %{data: for(member <- members, do: data(member))}
  end

  @doc """
  Renders a single member.
  """
  def show(%{member: member}) do
    %{data: data(member)}
  end

  defp data(%Member{} = member) do
    %{
      id: member.id
    }
  end
end
