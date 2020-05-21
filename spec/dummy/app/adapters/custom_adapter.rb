class CustomAdapter < Wor::Paginate::Adapters::Base
  def required_methods
    %i[page count]
  end

  def paginated_content
    @paginated_content ||= @content.page(@page).per((@limit * 0.3).to_i + 1)
  end

  delegate :count, :total_count, to: :paginated_content
end
