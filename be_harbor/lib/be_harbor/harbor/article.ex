defmodule BeHarbor.Harbor.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :name, :string
    field :text, :string
    belongs_to :user, BeHarbor.Users.User

    timestamps(type: :utc_datetime)
  end

  def changeset(article, attrs) do
    article
    |> cast(attrs, [:name, :text, :user_id])
    |> validate_required([:name, :text, :user_id])
  end
end
