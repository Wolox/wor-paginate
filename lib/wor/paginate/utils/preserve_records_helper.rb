require_relative 'uri_helper'

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
          content = self.content.where("#{field} <= :last_value", last_value: last_value)
          [content, UriHelper.replace_query_params(url, query_param_name => last_value)]
        end

        private

        attr_reader :content, :url, :options

        def by
          @by ||= begin
            by = options[:by]&.to_sym || :timestamp
            raise ArgumentError, "'by' option shuld be 'id' or 'timestamp'" unless
              %i[timestamp id].include? by

            by
          end
        end

        def field
          @field ||= options[:field] || case by
                                        when :timestamp
                                          :created_at
                                        when :id
                                          :id
                                        end
        end

        def last_value
          @last_value ||= begin
            query_param_value = UriHelper.query_params(url)[query_param_name]

            case by
            when :timestamp
              query_param_value ? Time.parse(query_param_value) : now_timestamp
            when :id
              query_param_value || content.maximum(field)
            end
          end
        end

        def now_timestamp
          Time.zone.now.iso8601(10)
        end

        def query_param_name
          @query_param_name ||= "#{field}_let"
        end
      end
    end
  end
end
