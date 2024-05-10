defmodule EventManager.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      @primary_key {:id, Ecto.UUID, autogenerate: {Ecto.UUID, :generate, []}}
      @foreign_key_type Ecto.UUID

      @timestamps_opts [type: :utc_datetime]
    end
  end
end
