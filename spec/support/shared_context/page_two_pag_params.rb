RSpec.shared_context 'with param page in 2' do
  let(:pagination_params) do
    { page: (DummyModel.count - Wor::Paginate::Config.default_per_page),
      count: (DummyModel.count - Wor::Paginate::Config.default_per_page),
      total_pages: (model_count / Wor::Paginate::Config.default_per_page.to_f).ceil,
      total_count: model_count, previous_page: 1, current_page: 2, next_page: nil }
  end
end
