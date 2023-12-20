defmodule BeHarborWeb.ArticleController do
  use BeHarborWeb, :controller

  alias BeHarbor.Harbor
  alias BeHarbor.Harbor.Article

  import Ecto.Query, only: [from: 2]
  action_fallback BeHarborWeb.FallbackController

  def index(conn, _params) do
    articles = Harbor.list_articles()
    render(conn, :index, articles: articles)
  end

  def create(conn,  article_params) do
    with {_conn, user} <- BeHarborWeb.APIAuthPlug.fetch(conn, []),
         article_params <- Map.put_new(article_params, "user_id", user.id),
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

    with :ok <- same_author(conn, article.user_id),
         {:ok, %Article{} = article} <- Harbor.update_article(article, article_params) do
      render(conn, :show, article: article)
    else
      :error ->
        conn
        |> resp(403, "Can't update this article")
    end
  end

  def delete(conn, %{"id" => id}) do
    article = Harbor.get_article!(id)

    with :ok <- same_author(conn, article.user_id),
         {:ok, %Article{}} <- Harbor.delete_article(article) do
      send_resp(conn, :no_content, "")
    else
      :error ->
        conn
        |> resp(403, "Can't delete this article")
    end
  end

  def by_user(conn, %{"user_id" => user_id}) do
    {user_id, _} = Integer.parse(user_id)

    articles =
      from(
        Article,
        where: [user_id: ^user_id],
        select: [:id, :name, :text]
      )
      |> BeHarbor.Repo.all()

    render(conn, :index, articles: articles)
  end

  defp same_author(conn, user_id) do
    {_conn, user} = BeHarborWeb.APIAuthPlug.fetch(conn, [])

    cond do
      user.id === user_id ->
        :ok

      true ->
        :error
    end
  end
end
