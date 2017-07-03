class CustomFormatter < Wor::Paginate::Formatter
  def format
    { page: serialized_content, current: current_page }
  end
end
