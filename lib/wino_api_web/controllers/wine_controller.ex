defmodule WinoApiWeb.WineController do
  use WinoApiWeb, :controller

  alias WinoApi.Wino
  alias WinoApi.Wino.Wine

  action_fallback WinoApiWeb.FallbackController

  def index(conn, _params) do
    wines = Wino.list_wines()
    render(conn, "index.json", wines: wines)
  end

  def create(conn, %{"wine" => wine_params}) do
    with {:ok, %Wine{} = wine} <- Wino.create_wine(wine_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.wine_path(conn, :show, wine))
      |> render("show.json", wine: wine)
    end
  end

  def show(conn, %{"id" => id}) do
    wine = Wino.get_wine!(id)
    render(conn, "show.json", wine: wine)
  end

  def update(conn, %{"id" => id, "wine" => wine_params}) do
    wine = Wino.get_wine!(id)

    with {:ok, %Wine{} = wine} <- Wino.update_wine(wine, wine_params) do
      render(conn, "show.json", wine: wine)
    end
  end

  def delete(conn, %{"id" => id}) do
    wine = Wino.get_wine!(id)

    with {:ok, %Wine{}} <- Wino.delete_wine(wine) do
      send_resp(conn, :no_content, "")
    end
  end
end
