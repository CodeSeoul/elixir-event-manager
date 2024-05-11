defmodule EventManager.Repo.Migrations.CreateMapLinks do
  use Ecto.Migration

  def change do
    create table(:map_links) do
      add :naver_map_link, :string
      add :t_map_link, :string
      add :google_map_link, :string
      add :kakao_map_link, :string
      add :venue_id, references(:venues, on_delete: :delete_all)

      timestamps()
    end
  end
end
