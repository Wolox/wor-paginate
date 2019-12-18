require 'wor/paginate/utils/uri_helper'

module Wor
  module Paginate
    module Formatters
      class Base
        include Utils::UriHelper
        attr_accessor :adapter, :content, :formatter, :options

        def initialize(adapter, options = {})
          @adapter = adapter
          @options = options
        end

        def format # rubocop: disable Metrics/MethodLength
          {
            page: serialized_content,
            count: count,
            total_pages: total_pages,
            total_count: total_count,
            current_page: current_page,
            previous_page: previous_page,
            next_page: next_page,
            next_page_url: page_url(next_page),
            previous_page_url: page_url(previous_page)
          }
        end

        protected

        delegate :count, :total_count, :total_pages, :previous_page, :next_page, to: :adapter

        def current_page
          adapter.page.to_i
        end

        def paginated_content
          @content ||= adapter.paginated_content
        end

        def serialized_content
          if serializer.present?
            return paginated_content.map { |item| serializer.new(item, options) }
          end
          if defined? ActiveModelSerializers::SerializableResource
            ActiveModelSerializers::SerializableResource.new(paginated_content).as_json
          else
            paginated_content.as_json
          end
        end

        def serializer
          options[:each_serializer]
        end

        def page_url(page)
          return nil unless page

          replace_query_params(current_url, page: page)
        end

        def current_url
          options[:_current_url]
        end
      end
    end
  end
end
