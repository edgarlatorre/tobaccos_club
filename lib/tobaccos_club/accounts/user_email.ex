defmodule TobaccosClub.Accounts.UserEmail do
  import Swoosh.Email
  import TobaccosClubWeb.Gettext

  def confirmation_instructions(user, url) do
    msg = """
    #{dgettext("users", "Hi %{email}", email: user.email)},

    #{dgettext("users", "You can confirm your account by visiting the URL below:")}

    #{url}

    #{dgettext("users", "If you didn't create an account with us, please ignore this.")}
    """

    new()
    |> to({user.email, user.email})
    |> from({gettext("Tobacco's Club"), "noreply@tabacos.club"})
    |> subject(dgettext("users", "Instructions to account confirmation"))
    |> html_body(msg)
    |> text_body(msg)
  end

  def change_email_instructions(user, url) do
    msg = """
    #{dgettext("users", "Hi %{email}", email: user.email)},

    #{dgettext("users", "You can change your email by visiting the URL below:")}

    #{url}

    #{dgettext("users", "If you didn't request this change, please ignore this.")}
    """

    new()
    |> to({user.email, user.email})
    |> from({gettext("Tobacco's Club"), "noreply@tabacos.club"})
    |> subject(dgettext("users", "Change email instructions"))
    |> html_body(msg)
    |> text_body(msg)
  end

  def reset_password_instructions(user, url) do
    msg = """
    #{dgettext("users", "Hi %{email}", email: user.email)},

    #{dgettext("users", "You can reset your password by visiting the URL below:")}

    #{url}

    #{dgettext("users", "If you didn't request this change, please ignore this.")}
    """

    new()
    |> to({user.email, user.email})
    |> from({gettext("Tobacco's Club"), "noreply@tabacos.club"})
    |> subject(dgettext("users", "Reset password instructions"))
    |> html_body(msg)
    |> text_body(msg)
  end
end
