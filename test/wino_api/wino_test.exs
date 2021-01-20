defmodule WinoApi.WinoTest do
  use WinoApi.DataCase

  alias WinoApi.Wino

  describe "wines" do
    alias WinoApi.Wino.Wine

    @valid_attrs %{alcohol: 120.5, color: "some color", name: "some name"}
    @update_attrs %{alcohol: 456.7, color: "some updated color", name: "some updated name"}
    @invalid_attrs %{alcohol: nil, color: nil, name: nil}

    def wine_fixture(attrs \\ %{}) do
      {:ok, wine} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Wino.create_wine()

      wine
    end

    test "list_wines/0 returns all wines" do
      wine = wine_fixture()
      assert Wino.list_wines() == [wine]
    end

    test "get_wine!/1 returns the wine with given id" do
      wine = wine_fixture()
      assert Wino.get_wine!(wine.id) == wine
    end

    test "create_wine/1 with valid data creates a wine" do
      assert {:ok, %Wine{} = wine} = Wino.create_wine(@valid_attrs)
      assert wine.alcohol == 120.5
      assert wine.color == "some color"
      assert wine.name == "some name"
    end

    test "create_wine/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wino.create_wine(@invalid_attrs)
    end

    test "update_wine/2 with valid data updates the wine" do
      wine = wine_fixture()
      assert {:ok, %Wine{} = wine} = Wino.update_wine(wine, @update_attrs)
      assert wine.alcohol == 456.7
      assert wine.color == "some updated color"
      assert wine.name == "some updated name"
    end

    test "update_wine/2 with invalid data returns error changeset" do
      wine = wine_fixture()
      assert {:error, %Ecto.Changeset{}} = Wino.update_wine(wine, @invalid_attrs)
      assert wine == Wino.get_wine!(wine.id)
    end

    test "delete_wine/1 deletes the wine" do
      wine = wine_fixture()
      assert {:ok, %Wine{}} = Wino.delete_wine(wine)
      assert_raise Ecto.NoResultsError, fn -> Wino.get_wine!(wine.id) end
    end

    test "change_wine/1 returns a wine changeset" do
      wine = wine_fixture()
      assert %Ecto.Changeset{} = Wino.change_wine(wine)
    end
  end
end
