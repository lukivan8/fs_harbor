defmodule BeHarborWeb.ArticleJSON do
  alias BeHarbor.Harbor.Article

  @doc """
  Renders a list of articles.
  """
  def index(%{articles: articles}) do
    %{data: for(article <- articles, do: data(article))}
  end

  @doc """
  Renders a single article.
  """
  def show(%{article: article}) do
    %{data: data(article)}
  end

  defp data(%Article{} = article) do
    %{
      id: article.id,
      name: article.name,
      text: article.text,
      user_id: article.user_id
    }
  end
end
