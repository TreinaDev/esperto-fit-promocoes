require 'rails_helper'

describe ApplicationHelper do
  context '#active_class?' do
    it 'returns "active" if same path' do
      allow(helper).to receive(:current_page?).and_return true
      expect(helper.active_class?(promotions_path)).to eq('active')
    end

    it 'returns "" not the same path' do
      allow(helper).to receive(:current_page?).and_return false
      expect(helper.active_class?(promotions_path)).to eq('')
    end
  end
end
