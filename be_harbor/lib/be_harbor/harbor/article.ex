defmodule BeHarbor.Harbor.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :name, :string
    field :text, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:name, :text])
    |> validate_required([:name, :text])
  end
end
