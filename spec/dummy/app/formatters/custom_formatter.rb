class CustomFormatter < Wor::Paginate::Formatter
  def format
    { items: serialized_content, current: current_page }
  end
end
