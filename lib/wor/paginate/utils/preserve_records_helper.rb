require_relative 'uri_helper'
require_relative 'preserve_modes'

module Wor
  module Paginate
    module Utils
      class PreserveRecordsHelper
        def initialize(content, url, options)
          @content = content
          @url = url
          @options = options
        end

        def call
          [content.where("#{field} <= :last_value", last_value: last_value),
           UriHelper.replace_query_params(url, query_param_name => last_value)]
        end

        private

        attr_reader :content, :url, :options

        def by
          @by ||= begin
            by = options[:by]&.to_s || 'timestamp'
            raise ArgumentError, "'by' option should be 'id' or 'timestamp'" unless
              %w[timestamp id].include? by
            "Wor::Paginate::Utils::PreserveModes::#{by.classify}".constantize
          end
        end

        def field
          @field ||= options[:field] || by.default_field
        end

        def last_value
          @last_value ||= begin
            query_param_value = UriHelper.query_params(url)[query_param_name]
            by.last_value(query_param_value, content, field)
          end
        end

        def query_param_name
          @query_param_name ||= "#{field}_let"
        end
      end
    end
  end
end
