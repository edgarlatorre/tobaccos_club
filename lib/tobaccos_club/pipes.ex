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
end
