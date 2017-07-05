Wor::Paginate.configure do |config|
  config.default_per_page = 100
  # config.default_page = 1

  config.page_param = :page
  config.per_page_param = :per

  # In case you want to use other format for your response, you can override our formatter here
  # Check https://url-to-the-docs
  # config.formatter = Wor::Paginate::Formatter
end
