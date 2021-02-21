defmodule TobaccosClub.Accounts.UserNotifier do
  alias TobaccosClub.Accounts.UserEmail
  alias TobaccosClub.Mailer

  defp deliver(email) do
    require Logger
    Logger.debug(email.text_body)
    Mailer.deliver!(email)

    {:ok, %{to: email.to, body: email.text_body}}
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    email = UserEmail.confirmation_instructions(user, url)
    deliver(email)
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    email = UserEmail.reset_password_instructions(user, url)
    deliver(email)
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    email = UserEmail.change_email_instructions(user, url)
    deliver(email)
  end
end
