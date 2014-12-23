require 'digest'

module Jekyll
  class AssetGenerator < Generator
    def generate(site)
      site.pages.select { |p| p.data['fingerprint'] }.each do |page|
        md5 = Digest::MD5.hexdigest(page.transform)
        fingerprinted_page = Page.new(site, site.source, page.dir, page.name)
        fingerprinted_page.basename = "#{page.basename}-#{md5}"
        fingerprinted_page.data = { 'original_url' => page.url }
        site.pages.push(fingerprinted_page)
      end
    end
  end

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
end

Liquid::Template.register_tag('asset_url', Jekyll::AssetUrlTag)
