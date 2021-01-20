defmodule WinoApiWeb.WineControllerTest do
  use WinoApiWeb.ConnCase

  alias WinoApi.Wino
  alias WinoApi.Wino.Wine

  @create_attrs %{
    alcohol: 120.5,
    color: "some color",
    name: "some name"
  }
  @update_attrs %{
    alcohol: 456.7,
    color: "some updated color",
    name: "some updated name"
  }
  @invalid_attrs %{alcohol: nil, color: nil, name: nil}

  def fixture(:wine) do
    {:ok, wine} = Wino.create_wine(@create_attrs)
    wine
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all wines", %{conn: conn} do
      conn = get(conn, Routes.wine_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create wine" do
    test "renders wine when data is valid", %{conn: conn} do
      conn = post(conn, Routes.wine_path(conn, :create), wine: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.wine_path(conn, :show, id))

      assert %{
               "id" => id,
               "alcohol" => 120.5,
               "color" => "some color",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.wine_path(conn, :create), wine: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update wine" do
    setup [:create_wine]

    test "renders wine when data is valid", %{conn: conn, wine: %Wine{id: id} = wine} do
      conn = put(conn, Routes.wine_path(conn, :update, wine), wine: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.wine_path(conn, :show, id))

      assert %{
               "id" => id,
               "alcohol" => 456.7,
               "color" => "some updated color",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, wine: wine} do
      conn = put(conn, Routes.wine_path(conn, :update, wine), wine: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete wine" do
    setup [:create_wine]

    test "deletes chosen wine", %{conn: conn, wine: wine} do
      conn = delete(conn, Routes.wine_path(conn, :delete, wine))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.wine_path(conn, :show, wine))
      end
    end
  end

  defp create_wine(_) do
    wine = fixture(:wine)
    %{wine: wine}
  end
end
