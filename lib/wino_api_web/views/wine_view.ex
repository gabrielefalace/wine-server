defmodule WinoApiWeb.WineView do
  use WinoApiWeb, :view
  alias WinoApiWeb.WineView

  def render("index.json", %{wines: wines}) do
    %{data: render_many(wines, WineView, "wine.json")}
  end

  def render("show.json", %{wine: wine}) do
    %{data: render_one(wine, WineView, "wine.json")}
  end

  def render("wine.json", %{wine: wine}) do
    %{id: wine.id,
      name: wine.name,
      color: wine.color,
      alcohol: wine.alcohol}
  end
end
