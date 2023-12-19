defmodule BeHarbor.Repo.Migrations.UserRole do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string, default: "user"
    end

    alter table(:articles) do
      add :author_id, references(:users, on_delete: :nothing), null: false
    end

    create index(:articles, [:author_id])
  end
end
