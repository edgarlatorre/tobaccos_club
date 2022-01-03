defmodule TobaccosClubWeb.ContactComponent do
  use TobaccosClubWeb, :live_component
  alias TobaccosClub.Contact.ContactMail
  alias TobaccosClub.Mailer
  import TobaccosClubWeb.Gettext

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("validate", %{"contact" => _contact}, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("send_email", %{"contact" => contact}, socket) do
    mail =
      ContactMail.main(contact["name"], contact["email"], contact["subject"], contact["message"])

    Mailer.deliver!(mail)

    {:noreply,
     socket
     |> put_flash(
       :info,
       dgettext("contact", "Message sent successfully")
     )
     |> push_redirect(to: socket.assigns.return_to)}
  end
end
