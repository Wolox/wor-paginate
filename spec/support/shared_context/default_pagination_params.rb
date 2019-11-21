RSpec.shared_context 'with default pagination params' do
  let(:pagination_params) do
    { page: Wor::Paginate::Config.default_per_page,
      count: Wor::Paginate::Config.default_per_page, total_count: model_count,
      total_pages: (model_count / Wor::Paginate::Config.default_per_page.to_f).ceil,
      previous_page: nil, current_page: Wor::Paginate::Config.default_page, next_page: 2 }
  end
end
