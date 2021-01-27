defmodule TobaccosClub.Services.SlugGeneratorTest do
  use TobaccosClub.DataCase
  alias TobaccosClub.Pipes.Blend
  alias TobaccosClub.Services.SlugGenerator
  import TobaccosClub.TobaccosFactory

  describe "generate slug for blend" do
    test "generate slug when it does  not exist" do
      assert "test-slug" == SlugGenerator.generate("Test Slug", Blend)
    end

    test "generate slug when it exists append counter" do
      insert(:blend, slug: "test-slug")
      assert "test-slug-1" == SlugGenerator.generate("Test Slug", Blend)

      insert(:blend, slug: "test-slug-1")
      assert "test-slug-2" == SlugGenerator.generate("Test Slug", Blend)
    end

    test "Remove special characters" do
      assert "test-slug-onetwo" == SlugGenerator.generate("Test, Sl'ug; (one)[two]", Blend)
    end
  end
end
