defmodule TobaccosClub.Reviewer do
  alias TobaccosClub.Pipes.Brand
  alias TobaccosClub.Repo
  import Ecto.Query

  @doc """
  Returns the list of brands.

  ## Examples

      iex> list_brands()
      [%Brand{}, ...]

  """
  def list_brands do
    Brand
    |> order_by(asc: :name)
    |> Repo.all()
  end

  @doc """
  Gets a single brand.

  Raises `Ecto.NoResultsError` if the Brand does not exist.

  ## Examples

      iex> get_brand!(123)
      %Brand{}

      iex> get_brand!(456)
      ** (Ecto.NoResultsError)

  """
  def get_brand!(id), do: Repo.get!(Brand, id)

  @doc """
  Creates a brand.

  ## Examples

      iex> create_brand(%{field: value})
      {:ok, %Brand{}}

      iex> create_brand(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_brand(attrs \\ %{}) do
    %Brand{}
    |> Brand.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a brand.

  ## Examples

      iex> update_brand(brand, %{field: new_value})
      {:ok, %Brand{}}

      iex> update_brand(brand, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_brand(%Brand{} = brand, attrs) do
    brand
    |> Brand.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a brand.

  ## Examples

      iex> delete_brand(brand)
      {:ok, %Brand{}}

      iex> delete_brand(brand)
      {:error, %Ecto.Changeset{}}

  """
  def delete_brand(%Brand{} = brand) do
    Repo.delete(brand)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking brand changes.

  ## Examples

      iex> change_brand(brand)
      %Ecto.Changeset{data: %Brand{}}

  """
  def change_brand(%Brand{} = brand, attrs \\ %{}) do
    Brand.changeset(brand, attrs)
  end

  def list_brands_starting_with("all"), do: list_brands()

  def list_brands_starting_with(letter) do
    Brand
    |> where([brand], ilike(brand.name, ^"#{letter}%"))
    |> order_by(asc: :name)
    |> Repo.all()
  end

  def find_brands_name_includes(search_text) do
    Brand
    |> where([brand], ilike(brand.name, ^"%#{search_text}%"))
    |> Repo.all()
  end

  def get_brand_by_slug(slug) do
    Brand |> Repo.get_by(slug: slug) |> Repo.preload(:blends)
  end

  def get_brand_by_name(name) do
    Repo.get_by(Brand, name: name)
  end

  alias TobaccosClub.Pipes.BlendType

  @doc """
  Returns the list of blend_types.

  ## Examples

      iex> list_blend_types()
      [%BlendType{}, ...]

  """
  def list_blend_types do
    Repo.all(BlendType)
  end

  @doc """
  Gets a single blend_type.

  Raises `Ecto.NoResultsError` if the Blend type does not exist.

  ## Examples

      iex> get_blend_type!(123)
      %BlendType{}

      iex> get_blend_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blend_type!(id), do: Repo.get!(BlendType, id)

  @doc """
  Creates a blend_type.

  ## Examples

      iex> create_blend_type(%{field: value})
      {:ok, %BlendType{}}

      iex> create_blend_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blend_type(attrs \\ %{}) do
    %BlendType{}
    |> BlendType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blend_type.

  ## Examples

      iex> update_blend_type(blend_type, %{field: new_value})
      {:ok, %BlendType{}}

      iex> update_blend_type(blend_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blend_type(%BlendType{} = blend_type, attrs) do
    blend_type
    |> BlendType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a blend_type.

  ## Examples

      iex> delete_blend_type(blend_type)
      {:ok, %BlendType{}}

      iex> delete_blend_type(blend_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blend_type(%BlendType{} = blend_type) do
    Repo.delete(blend_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blend_type changes.

  ## Examples

      iex> change_blend_type(blend_type)
      %Ecto.Changeset{data: %BlendType{}}

  """
  def change_blend_type(%BlendType{} = blend_type, attrs \\ %{}) do
    BlendType.changeset(blend_type, attrs)
  end

  def get_blend_type_by_name(name) do
    Repo.get_by(BlendType, name: name)
  end

  alias TobaccosClub.Pipes.Blend

  def paginate_blends(params \\ []) do
    Blend
    |> order_by(asc: :name)
    # |> Repo.preload(:brand)
    |> Repo.paginate(params)
  end

  def paginate_blends_starting_with("all"), do: paginate_brands()

  def paginate_blends_starting_with(letter) do
    Blend
    |> where([blend], ilike(blend.name, ^"#{letter}%"))
    |> order_by(asc: :name)
    |> Repo.paginate()
  end

  def paginate_blends_name_includes(search_text) do
    Blend
    |> where([blend], ilike(blend.name, ^"%#{search_text}%"))
    |> Repo.paginate()
  end

  @doc """
  Returns the list of blends.

  ## Examples

      iex> list_blends()
      [%Blend{}, ...]

  """
  def list_blends do
    Repo.all(Blend)
  end

  def paginate_brands(params \\ []) do
    Repo.paginate(Brand, params)
  end

  @doc """
  Gets a single blend.

  Raises `Ecto.NoResultsError` if the Blend does not exist.

  ## Examples

      iex> get_blend!(123)
      %Blend{}

      iex> get_blend!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blend!(id), do: Repo.get!(Blend, id)

  @doc """
  Creates a blend.

  ## Examples

      iex> create_blend(%{field: value})
      {:ok, %Blend{}}

      iex> create_blend(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blend(attrs \\ %{}) do
    %Blend{}
    |> Blend.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blend.

  ## Examples

      iex> update_blend(blend, %{field: new_value})
      {:ok, %Blend{}}

      iex> update_blend(blend, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blend(%Blend{} = blend, attrs) do
    blend
    |> Blend.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a blend.

  ## Examples

      iex> delete_blend(blend)
      {:ok, %Blend{}}

      iex> delete_blend(blend)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blend(%Blend{} = blend) do
    Repo.delete(blend)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blend changes.

  ## Examples

      iex> change_blend(blend)
      %Ecto.Changeset{data: %Blend{}}

  """
  def change_blend(%Blend{} = blend, attrs \\ %{}) do
    Blend.changeset(blend, attrs)
  end
end
