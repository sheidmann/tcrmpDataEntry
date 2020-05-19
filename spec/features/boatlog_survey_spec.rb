require 'rails_helper'
require 'spec_helper'

Capybara.current_driver = :selenium

describe "Manager viewing boatlog edit page", :js => true, type: :feature do
  # before(:each) do
  #   @manager = create(:manager)
  #   @blmanager = create(:boatlog_manager, user_id: @manager.id)
  #   @boatlog = create(:boatlog, manager_id: @blmanager.id)
  #   @observer = create(:user)
  #   @surveytype = create(:survey_type)
  #   visit('/login')
  #   sign_in(@manager)
  # end
  # it "sees list of surveys" do
  #   @survey = build(:boatlog_survey, boatlog_id: @boatlog.id, user_id: @observer.id, survey_type_id: @surveytype.id)
  #   visit('/boatlogs')
  #   click_link("edit")
  #   expect(page).to have_content "Special Survey"
  #   puts 'manager can see boatlog surveys'
  # end
  # it "can create a boatlog" do
  #     visit('/boatlogs')
  #     click_button("New Boatlog")
  #     expect(page).to have_content "Site Name"

  #     @boatlog = build(:boatlog)
  #     fill_in "Site Name", with: @boatlog.site
  #     fill_in "Date Completed", with: @boatlog.date_completed
  #     fill_in "Begin Time", with: @boatlog.begin_time.strftime("%H:%M")
  #     select @blmanager.project, :from => "Project"
  #     click_button("New Boatlog")
  #     expect(page).to have_content "Boatlog successfully created"
  #     puts 'manager can create a new boatlog'
  #   end
  #   it "can edit a boatlog" do
  #     @boatlog = create(:boatlog, manager_id: @blmanager.id)
  #     visit('/boatlogs')

  #     click_link('edit')
  #     expect(page).to have_content "Edit Boatlog"

  #     click_button("Update Boatlog")
  #     expect(page).to have_content "Boatlog successfully updated"
  #     puts 'manager can edit boatlog'
  #   end
  #   it "can delete a boatlog" do
  #     @boatlog = create(:boatlog, manager_id: @blmanager.id)
  #     visit('/boatlogs')
  #     accept_confirm do
  #       click_link 'destroy'
  #     end
  #     expect(page).to have_content "Boatlog deleted"
  #     puts 'manager can delete boatlog'
  #   end
  # end
end