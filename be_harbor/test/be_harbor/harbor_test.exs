defmodule BeHarbor.HarborTest do
  use BeHarbor.DataCase

  alias BeHarbor.Harbor

  describe "articles" do
    alias BeHarbor.Harbor.Article

    import BeHarbor.HarborFixtures

    @invalid_attrs %{name: nil, text: nil}

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Harbor.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Harbor.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{name: "some name", text: "some text"}

      assert {:ok, %Article{} = article} = Harbor.create_article(valid_attrs)
      assert article.name == "some name"
      assert article.text == "some text"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Harbor.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      update_attrs = %{name: "some updated name", text: "some updated text"}

      assert {:ok, %Article{} = article} = Harbor.update_article(article, update_attrs)
      assert article.name == "some updated name"
      assert article.text == "some updated text"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Harbor.update_article(article, @invalid_attrs)
      assert article == Harbor.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Harbor.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Harbor.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Harbor.change_article(article)
    end
  end
end
