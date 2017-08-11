Wor::Paginate.configure do |config|
  config.default_per_page = 25
  # config.default_page = 1

  config.page_param = :page
  config.per_page_param = :limit

  # In case you want to use other format for your response, you can override our formatter here
  # You can extend from Wor::Paginate::Formatter and override the 'format' method
  # For more info about available methods for formatters see:
  # https://github.com/Wolox/wor-paginate/blob/master/lib/wor/paginate/formatter.rb
  # config.formatter = Wor::Paginate::Formatter
end
