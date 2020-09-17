Wor::Paginate.configure do |config|
  config.default_per_page = 25
  config.default_page = 1

  config.page_param = :page
  config.per_page_param = :per

  config.formatter = Wor::Paginate::Formatters::AmsFormatter
end
