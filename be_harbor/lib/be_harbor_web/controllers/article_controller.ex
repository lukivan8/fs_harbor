defmodule BeHarborWeb.ArticleController do
  use BeHarborWeb, :controller

  alias BeHarbor.Harbor
  alias BeHarbor.Harbor.Article

  action_fallback BeHarborWeb.FallbackController

  def index(conn, _params) do
    articles = Harbor.list_articles()
    render(conn, :index, articles: articles)
  end

  def create(conn, %{"article" => article_params}) do
    with {_conn, user} <- BeHarborWeb.APIAuthPlug.fetch(conn, []),
         article_params <- Map.put_new(article_params, "author_id", user.id),
         article_params <- IO.inspect(article_params),
         {:ok, %Article{} = article} <- Harbor.create_article(article_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/articles/#{article}")
      |> render(:show, article: article)
    end
  end

  def show(conn, %{"id" => id}) do
    article = Harbor.get_article!(id)
    render(conn, :show, article: article)
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Harbor.get_article!(id)

    with {:ok, %Article{} = article} <- Harbor.update_article(article, article_params) do
      render(conn, :show, article: article)
    end
  end

  def delete(conn, %{"id" => id}) do
    article = Harbor.get_article!(id)

    with {:ok, %Article{}} <- Harbor.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end
end
