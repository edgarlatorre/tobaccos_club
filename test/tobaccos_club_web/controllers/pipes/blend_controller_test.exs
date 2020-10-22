defmodule TobaccosClubWeb.Pipes.BlendControllerTest do
  use TobaccosClubWeb.ConnCase
  import TobaccosClub.TobaccosFactory

  describe "index" do
    test "lists all blends", %{conn: conn} do
      conn = get(conn, Routes.pipes_blend_path(conn, :index))
      assert html_response(conn, 200) =~ "Mixturas"
    end
  end

  describe "new blend" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.pipes_blend_path(conn, :new))
      assert html_response(conn, 200) =~ "New Blend"
    end
  end

  describe "create blend" do
    test "when data is valid", %{conn: conn} do
      brand = insert(:brand)
      blend_type = insert(:blend_type)
      blend_params = params_for(:blend, brand_id: brand.id, blend_type_id: blend_type.id)

      conn = post(conn, Routes.pipes_blend_path(conn, :create), blend: blend_params)

      assert %{id: id} = redirected_params(conn)
    end
  end

  describe "edit blend" do
    setup [:create_blend]

    test "renders form for editing chosen blend", %{conn: conn, blend: blend} do
      conn = get(conn, Routes.pipes_blend_path(conn, :edit, blend))
      assert html_response(conn, 200) =~ "Edit Blend"
    end
  end

  describe "update blend" do
    setup [:create_blend]

    test "redirects when data is valid", %{conn: conn, blend: blend} do
      conn = put(conn, Routes.pipes_blend_path(conn, :update, blend), blend: %{name: "Changed"})
      assert redirected_to(conn) == Routes.pipes_blend_path(conn, :show, blend)

      conn = get(conn, Routes.pipes_blend_path(conn, :show, blend))
      assert html_response(conn, 200)
    end
  end

  describe "delete blend" do
    setup [:create_blend]

    test "deletes chosen blend", %{conn: conn, blend: blend} do
      conn = delete(conn, Routes.pipes_blend_path(conn, :delete, blend))
      assert redirected_to(conn) == Routes.pipes_blend_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.pipes_blend_path(conn, :show, blend))
      end
    end
  end

  defp create_blend(_) do
    blend = insert(:blend)
    %{blend: blend}
  end
end
