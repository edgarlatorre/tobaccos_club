defmodule TobaccosClub.Accounts.UserEmail do
  use Phoenix.Swoosh,
    view: TobaccosClubWeb.EmailView,
    layout: {TobaccosClubWeb.LayoutView, :email}

  import Swoosh.Email
  import TobaccosClubWeb.Gettext

  def confirmation_instructions(user, url) do
    new()
    |> to({user.email, user.email})
    |> from({gettext("Tobacco's Club"), "noreply@tabacos.club"})
    |> subject(dgettext("users", "Instructions to account confirmation"))
    |> render_body("accounts/account_confirmation.html", %{user: user, url: url})
  end

  def change_email_instructions(user, url) do
    new()
    |> to({user.email, user.email})
    |> from({gettext("Tobacco's Club"), "noreply@tabacos.club"})
    |> subject(dgettext("users", "Change email instructions"))
    |> render_body("accounts/change_email_confirmation.html", %{user: user, url: url})
  end

  def reset_password_instructions(user, url) do
    new()
    |> to({user.email, user.email})
    |> from({gettext("Tobacco's Club"), "noreply@tabacos.club"})
    |> subject(dgettext("users", "Reset password instructions"))
    |> render_body("accounts/reset_password.html", %{user: user, url: url})
  end
end
