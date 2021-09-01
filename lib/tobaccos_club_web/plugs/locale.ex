defmodule TobaccosClubWeb.Plugs.Locale do
  alias Plug.Conn

  @behaviour Plug
  @locales Gettext.known_locales(TobaccosClubWeb.Gettext)

  defguard known_locale?(locale) when locale in @locales

  @impl Plug
  def init(_opts), do: nil

  @impl Plug
  def call(conn, _opts) do
    locale = fetch_and_set_locale(conn)

    conn
    |> Conn.assign(:locale, locale)
    |> Conn.put_session(:locale, locale)
  end

  defp fetch_and_set_locale(conn) do
    case locale_from_params(conn) do
      nil ->
        Gettext.get_locale()

      locale ->
        if locale != Gettext.get_locale() do
          Gettext.put_locale(locale)
        end

        locale
    end
  end

  defp locale_from_params(%Conn{params: %{"locale" => locale}})
       when known_locale?(locale) do
    locale
  end

  defp locale_from_params(_conn), do: nil
end
