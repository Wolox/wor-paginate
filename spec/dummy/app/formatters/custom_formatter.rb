class CustomFormatter < Wor::Paginate::Formatters::AmsFormatter
  def format
    { items: serialized_content, current: current_page }
  end
end
