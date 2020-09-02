defmodule TobaccosClubWeb.Pipes.BlendController do
  use TobaccosClubWeb, :controller

  alias TobaccosClub.Pipes.Blend
  alias TobaccosClub.Reviewer

  def index(conn, _params) do
    alphabet = for n <- ?a..?z, do: String.capitalize(<<n::utf8>>)
    blends = Reviewer.list_blends()
    render(conn, "index.html", blends: blends, alphabet: alphabet)
  end

  def new(conn, _params) do
    changeset = Reviewer.change_blend(%Blend{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"blend" => blend_params}) do
    case Reviewer.create_blend(blend_params) do
      {:ok, blend} ->
        conn
        |> put_flash(:info, "Blend created successfully.")
        |> redirect(to: Routes.pipes_blend_path(conn, :show, blend))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    blend = Reviewer.get_blend!(id)
    blend_type = Reviewer.get_blend_type!(blend.blend_type_id)
    brand = Reviewer.get_brand!(blend.brand_id)

    render(conn, "show.html", blend: blend, blend_type: blend_type, brand: brand)
  end

  def edit(conn, %{"id" => id}) do
    blend = Reviewer.get_blend!(id)
    changeset = Reviewer.change_blend(blend)
    render(conn, "edit.html", blend: blend, changeset: changeset)
  end

  def update(conn, %{"id" => id, "blend" => blend_params}) do
    blend = Reviewer.get_blend!(id)

    case Reviewer.update_blend(blend, blend_params) do
      {:ok, blend} ->
        conn
        |> put_flash(:info, "Blend updated successfully.")
        |> redirect(to: Routes.pipes_blend_path(conn, :show, blend))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", blend: blend, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    blend = Reviewer.get_blend!(id)
    {:ok, _blend} = Reviewer.delete_blend(blend)

    conn
    |> put_flash(:info, "Blend deleted successfully.")
    |> redirect(to: Routes.pipes_blend_path(conn, :index))
  end
end
