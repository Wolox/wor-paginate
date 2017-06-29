module Wor
  module Paginate
    module Config
      attr_accessor :default_per_page, :default_page, :page_param, :per_page_param, :formatter

      module_function

      def default_per_page
        @default_per_page ||= 25
      end

      def default_page
        @default_page ||= 1
      end

      def page_param
        @page_param ||= :page
      end

      def per_page_param
        @per_page_param ||= :per_page
      end
    end
  end
end
