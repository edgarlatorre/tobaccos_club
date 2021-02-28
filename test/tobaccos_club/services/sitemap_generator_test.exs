defmodule TobaccosClub.Services.SitemapGeneratorTest do
  import TobaccosClub.TobaccosFactory
  use TobaccosClub.DataCase
  alias TobaccosClub.Services.SitemapGenerator

  describe "generate sitemap for blends" do
    test "generate sitemap without blends" do
      assert """
             <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n
             </urlset>
             """ == SitemapGenerator.generate([])
    end

    test "generate" do
      brand = insert(:brand, slug: "brand-slug")

      blends =
        insert_list(1, :blend,
          slug: "blend-slug",
          brand: brand,
          updated_at: ~N[2021-02-27 13:52:28]
        )

      assert """
             <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n
               <url>
                 <loc>https://www.tabacos.club/brand-slug/blend-slug</loc>
                 <lastmod>2021-02-27</lastmod>
                 <changefreq>daily</changefreq>
                 <priority>0.9</priority>
               </url>\n
             </urlset>
             """ == SitemapGenerator.generate(blends)
    end
  end
end
