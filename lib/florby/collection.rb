module Florby
  class Collection
    def initialize
      files = Dir.glob(File.join(Dir.pwd, 'src', '*.md'))
      @hash = files.map { |file| [File.basename(file).gsub(/\.md$/, ''), Page.new(file: file)] }.to_h
    end

    def titles
      @hash.keys
    end

    def all_pages
      @hash.values.sort_by(&:created).reverse
    end

    def pages
      all_pages.reject(&:exclude_from_collections?)
    end

    def find(title)
      @hash[title]
    end
  end
end
