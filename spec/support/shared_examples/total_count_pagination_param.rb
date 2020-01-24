shared_examples 'total count pagination param' do
  it 'responds with the total_count passed to render_paginated, overrides the real total_count' do
    expect(response_body(response)['total_count']).to(
      be Constants::DEFAULT_TOTAL_COUNT[:total_count]
    )
    expect(response_body(response)['total_count']).not_to be DummyModel.count
  end
end
