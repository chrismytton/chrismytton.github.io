require 'digest'

# Asset fingerprinting plugin
module Jekyll
  # If a page has `fingerprint: true` in the frontmatter then generate
  # a version with an md5 in the filename.
  class AssetGenerator < Generator
    def generate(site)
      site.pages.select { |p| p.data['fingerprint'] }.each do |page|
        site.pages.push(fingerprint(page))
      end
    end

    def fingerprint(page)
      md5 = Digest::MD5.hexdigest(page.transform)
      Page.new(page.site, page.site.source, page.dir, page.name).tap do |p|
        p.basename = "#{page.basename}-#{md5}"
        p.data['original_url'] = page.url
      end
    end
  end

  # Template tag for producing the md5 url to an asset.
  class AssetUrlTag < Liquid::Tag
    def initialize(_tag_name, url, _tokens)
      @url = url.strip
    end

    def render(context)
      site = context.registers[:site]
      page = site.pages.select { |p| p.data['original_url'] == @url }.first
      page.url
    end
  end

  Liquid::Template.register_tag('asset_url', Jekyll::AssetUrlTag)
end
