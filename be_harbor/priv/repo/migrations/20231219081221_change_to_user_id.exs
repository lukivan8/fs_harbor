defmodule BeHarbor.Repo.Migrations.ChangeToUserId do
  use Ecto.Migration

  def change do
    rename table(:articles), :author_id, to: :user_id
  end
end
