shared_examples 'valid page' do
  it 'responds with valid page' do
    expect(response_body(response)['page']).to eq expected_list
  end
end
