require 'rails_helper'
# TODO: - use page object here too

module Pwb
  RSpec.describe "Default theme page part content", type: :feature, js: false do
    context 'for contact-us page' do
      let!(:pwb_page) { FactoryGirl.create(:contact_us_page_with_page_part)}
      # calling above :page would clash with page object

      let(:prop) { FactoryGirl.create(:pwb_prop, :sale) }

      scenario 'when general contact form is filled' do
        page_content_html = pwb_page.contents.find_by_page_part_key "content_html"
        page_content_html.raw = "Content html raw"
        page_content_html.save!

        visit('/contact-us')

        expect(page).to have_content 'Content html raw'
      end
    end
  end
end