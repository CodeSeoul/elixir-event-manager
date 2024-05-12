defmodule EventManager.Members.Schemas.Member do
  use EventManager.Schema

  import Ecto.Changeset

  @email_regex ~r<
    (?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*
    |"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\
    [\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+
    [a-z0-9](?:[a-z0-9-]*[a-z0-9])?|
    \[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)
    \.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:
    (?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\
    [\x01-\x09\x0b\x0c\x0e-\x7f])+)\])
  >ix

  schema "members" do
    field(:username, :string)
    field(:display_name, :string)
    field(:email, :string)
    field(:phone, :string)
    field(:image_url, :string)
    field(:short_bio, :string)

    timestamps()
  end

  def changeset(member, attrs) do
    member
    |> cast(attrs, [:username, :display_name, :email, :phone, :image_url, :short_bio])
    |> validate_required([:username, :display_name, :email])
    |> validate_format(:email, @email_regex)
    |> unique_constraint([:username])
    |> unique_constraint([:email])
  end
end
