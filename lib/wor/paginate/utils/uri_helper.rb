module Wor
  module Paginate
    module Utils
      module UriHelper
        def replace_query_params(uri_string, new_query)
          uri = URI.parse(uri_string)
          query = Rack::Utils.parse_query(uri.query)
          uri.query = Rack::Utils.build_query(query.with_indifferent_access.merge(new_query))
          uri.to_s
        end

        module_function :replace_query_params
      end
    end
  end
end
