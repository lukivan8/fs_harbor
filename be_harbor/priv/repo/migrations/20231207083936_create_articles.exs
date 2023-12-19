defmodule BeHarbor.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :name, :string
      add :text, :string

      timestamps(type: :utc_datetime)
    end
  end
end
