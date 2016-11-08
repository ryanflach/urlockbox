require 'rails_helper'

RSpec.describe Api::V1::LinksController, type: :request do
  it 'returns JSON data when updating read status' do
    user = User.create!(email: 'hello@example.com', password: 'pass')

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)

    link = user.links.create!(
      title: 'Google',
      url: 'http://www.google.com'
    )

    put "/api/v1/links/#{link.id}"

    returned_json = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(returned_json['read']).to eq('true')
    expect(returned_json['title']).to eq(link.title)
    expect(returned_json['url']).to eq(link.url)
  end

  it 'returns JSON data when deleting a link' do
    user = User.create!(email: 'hello@example.com', password: 'pass')

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)

    link = user.links.create!(
      title: 'Google',
      url: 'http://www.google.com'
    )

    delete "/api/v1/links/#{link.id}"

    returned_json = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(returned_json['title']).to eq(link.title)
    expect(returned_json['url']).to eq(link.url)
    expect(Link.count).to eq(0)
  end
end
