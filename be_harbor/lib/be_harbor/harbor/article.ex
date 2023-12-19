defmodule BeHarbor.Harbor.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :name, :string
    field :text, :string
    belongs_to :author, BeHarbor.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:name, :text, :author_id])
    |> validate_required([:name, :text, :author_id])
  end
end
