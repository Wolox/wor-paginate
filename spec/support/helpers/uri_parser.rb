module UriParser
  def get_page_from(uri)
    return nil if uri.nil?

    Rack::Utils.parse_query(URI.parse(uri).query)['page'].to_i
  end

  module_function :get_page_from
end
