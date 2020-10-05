require 'rails_helper'

describe 'Promotion registration' do
  it 'must be admin in to create' do
    user = create(:user, admin: false)
    login_as user
    post promotions_path, params: {}

    expect(response).to redirect_to(root_path)
  end
end
