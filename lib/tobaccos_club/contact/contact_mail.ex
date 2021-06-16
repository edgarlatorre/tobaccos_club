defmodule TobaccosClub.Contact.ContactMail do
  use Phoenix.Swoosh,
    view: TobaccosClubWeb.EmailView,
    layout: {TobaccosClubWeb.LayoutView, :email}

  import Swoosh.Email
  import TobaccosClubWeb.Gettext

  def main(name, email, subject, message) do
    contact_email = Application.get_env(:tobaccos_club, :contact_email)

    new()
    |> to({contact_email, contact_email})
    |> from({gettext("Tobacco's Club - Contact"), "noreply@tabacos.club"})
    |> subject("#{subject}: #{name}")
    |> render_body("contact/contact.html", %{name: name, contact: email, message: message})
  end
end
