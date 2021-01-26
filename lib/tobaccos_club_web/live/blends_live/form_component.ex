defmodule TobaccosClubWeb.BlendsLive.FormComponent do
  use TobaccosClubWeb, :live_component
  alias TobaccosClub.Pipes
  alias TobaccosClub.Reviewer
  alias TobaccosClub.Services.SlugGenerator

  @impl true
  def update(%{blend: blend} = assigns, socket) do
    changeset = Reviewer.change_blend(blend)

    blend_types = Enum.map(Reviewer.list_blend_types(), &{&1.name, &1.id})
    cuts = Enum.map(Pipes.list_cuts(), &{&1.name, &1.id})
    countries = Enum.map(Pipes.list_countries(), &{&1.name, &1.id})
    brands = Enum.map(Reviewer.list_brands(), &{&1.name, &1.id})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(
       changeset: changeset,
       blend_types: blend_types,
       cuts: cuts,
       countries: countries,
       brands: brands
     )}
  end

  @impl true
  def handle_event("validate", %{"blend" => blend_params}, socket) do
    changeset =
      socket.assigns.blend
      |> Reviewer.change_blend(blend_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"blend" => blend_params}, socket) do
    save_blend(socket, socket.assigns.action, blend_params)
  end

  defp save_blend(socket, :edit, blend_params) do
    case Reviewer.update_blend(socket.assigns.blend, blend_params) do
      {:ok, _blend} ->
        {:noreply,
         socket
         |> put_flash(
           :info,
           Gettext.gettext(TobaccosClubWeb.Gettext, "Blend updated successfully")
         )
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_blend(socket, :new, blend_params) do
    slug = SlugGenerator.generate(blend_params["name"], Pipes.Blend)

    case Reviewer.create_blend(Map.put(blend_params, "slug", slug)) do
      {:ok, _blend} ->
        {:noreply,
         socket
         |> put_flash(
           :info,
           Gettext.gettext(TobaccosClubWeb.Gettext, "Blend created successfully")
         )
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
