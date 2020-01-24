class CustomFormatter < Wor::Paginate::Formatters::Base
  def format
    { items: serialized_content, current: current_page }
  end
end
