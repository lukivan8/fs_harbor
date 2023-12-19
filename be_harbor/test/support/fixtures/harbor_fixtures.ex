defmodule BeHarbor.HarborFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BeHarbor.Harbor` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        name: "some name",
        text: "some text"
      })
      |> BeHarbor.Harbor.create_article()

    article
  end
end
