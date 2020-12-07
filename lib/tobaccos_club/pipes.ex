defmodule TobaccosClub.Pipes do
  @moduledoc """
  The Pipes context.
  """

  import Ecto.Query, warn: false
  alias TobaccosClub.Repo

  alias TobaccosClub.Pipes.Cut

  @doc """
  Returns the list of cuts.

  ## Examples

      iex> list_cuts()
      [%Cut{}, ...]

  """
  def list_cuts do
    Repo.all(Cut)
  end

  @doc """
  Returns the list of cuts by ids.

  ## Examples

      iex> list_cuts([1, 2, 3])
      [%Cut{id: 1}, ...]

  """
  def list_cuts_by_ids(ids) do
    query = from(b in Cut, where: b.id in ^ids)

    Repo.all(query)
  end

  @doc """
  Gets a single cut.

  Raises `Ecto.NoResultsError` if the Cut does not exist.

  ## Examples

      iex> get_cut!(123)
      %Cut{}

      iex> get_cut!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cut!(id), do: Repo.get!(Cut, id)

  def get_cut_by_name(name), do: Repo.get_by(Cut, name: name)

  @doc """
  Creates a cut.

  ## Examples

      iex> create_cut(%{field: value})
      {:ok, %Cut{}}

      iex> create_cut(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cut(attrs \\ %{}) do
    %Cut{}
    |> Cut.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cut.

  ## Examples

      iex> update_cut(cut, %{field: new_value})
      {:ok, %Cut{}}

      iex> update_cut(cut, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cut(%Cut{} = cut, attrs) do
    cut
    |> Cut.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cut.

  ## Examples

      iex> delete_cut(cut)
      {:ok, %Cut{}}

      iex> delete_cut(cut)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cut(%Cut{} = cut) do
    Repo.delete(cut)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cut changes.

  ## Examples

      iex> change_cut(cut)
      %Ecto.Changeset{data: %Cut{}}

  """
  def change_cut(%Cut{} = cut, attrs \\ %{}) do
    Cut.changeset(cut, attrs)
  end

  alias TobaccosClub.Pipes.Country

  @doc """
  Returns the list of countries.

  ## Examples

      iex> list_countries()
      [%Country{}, ...]

  """
  def list_countries do
    Repo.all(Country)
  end

  @doc """
  Gets a single country.

  Raises `Ecto.NoResultsError` if the Country does not exist.

  ## Examples

      iex> get_country!(123)
      %Country{}

      iex> get_country!(456)
      ** (Ecto.NoResultsError)

  """
  def get_country!(id), do: Repo.get!(Country, id)

  def get_country_by_locale(locale), do: Repo.get_by(Country, locale: locale)

  @doc """
  Creates a country.

  ## Examples

      iex> create_country(%{field: value})
      {:ok, %Country{}}

      iex> create_country(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_country(attrs \\ %{}) do
    %Country{}
    |> Country.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a country.

  ## Examples

      iex> update_country(country, %{field: new_value})
      {:ok, %Country{}}

      iex> update_country(country, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_country(%Country{} = country, attrs) do
    country
    |> Country.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a country.

  ## Examples

      iex> delete_country(country)
      {:ok, %Country{}}

      iex> delete_country(country)
      {:error, %Ecto.Changeset{}}

  """
  def delete_country(%Country{} = country) do
    Repo.delete(country)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking country changes.

  ## Examples

      iex> change_country(country)
      %Ecto.Changeset{data: %Country{}}

  """
  def change_country(%Country{} = country, attrs \\ %{}) do
    Country.changeset(country, attrs)
  end
end
