require 'rails_helper'
require 'spec_helper'

Capybara.current_driver = :selenium

describe "Manager viewing boatlog index", :js => true, type: :feature do
    before(:each) do
	    @manager = create(:manager) # create a user (who is a manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id) # create a manager
      @site = create(:site, site_name: "My Site")
      @surveytype = create(:survey_type, type_name: "Special Survey")
	    visit('/login')
	    sign_in(@manager)
    end
    it "sees array of boatlogs" do
      @boatlog = create(:boatlog, site_id: @site.id, manager_id: @blmanager.id)
      visit('/boatlogs')
      expect(page).to have_content "My Site"
      expect(page).to have_css('tr')
      puts 'manager can view boatlogs with option to view'
    end
    it "can create a boatlog" do
      visit('/boatlogs')
      click_button("New Boatlog")
      expect(page).to have_content "Site Name"

      @boatlog = build(:boatlog, site_id: @site.id)
      select @boatlog.site.site_name, :from => "Site Name"
      fill_in "Date Completed", with: @boatlog.date_completed.strftime("%Y-%m-%d")
      fill_in "Begin Time", with: @boatlog.begin_time.strftime("%H:%M")
      select @blmanager.project, :from => "Project"

      @bl_survey = build(:boatlog_survey, user_id: @manager.id, survey_type_id: @surveytype.id)
      select @bl_survey.user.name#, :from => "Observer"
      select @bl_survey.survey_type.type_name#, :from => "Survey Type"
      fill_in("boatlog_boatlog_surveys_attributes_0_rep", with: @bl_survey.rep)

      click_button("Save Boatlog")
      expect(page).to have_content "Boatlog successfully created"
      puts 'manager can create a new boatlog'
    end
    it "can view a boatlog" do
      @boatlog = create(:boatlog, manager_id: @blmanager.id, site_id: @site.id)
      @bl_survey = create(:boatlog_survey, boatlog_id: @boatlog.id, survey_type_id: @surveytype.id)
      # I can't make Capybara click on the table row, so we just have to visit the link
      #visit('/boatlogs')
      # Code I tried that got close but didn't work:
      #find(:xpath, "//table/tbody/tr[@href='#{boatlog_path(@boatlog.id)}']").click # can't find
      #find("tr[id='#{@boatlog.id}']").click # No error but doesn't show boatlog
      #find(:xpath, '//table/tbody/tr').click # No error but doesn't show boatlog
      visit("#{boatlog_path(@boatlog.id)}")
      expect(page).to have_content "My Site"
      expect(page).to have_content "Special Survey"
      puts 'manager can view boatlog and associated surveys'
    end
    it "can edit a boatlog" do
      @boatlog = create(:boatlog, manager_id: @blmanager.id)
      visit('/boatlogs')

      visit("#{boatlog_path(@boatlog.id)}")
      click_button('Edit Boatlog')
      expect(page).to have_content "Edit Boatlog"

      click_button("Save Boatlog")
      expect(page).to have_content "Boatlog successfully updated"
      puts 'manager can edit boatlog'
    end
    it "can delete a boatlog" do
      @boatlog = create(:boatlog, manager_id: @blmanager.id)
      visit('/boatlogs')

      visit("#{boatlog_path(@boatlog.id)}")
      accept_confirm do
        click_button('Delete Boatlog')
      end
      expect(page).to have_content "Boatlog deleted"
      puts 'manager can delete boatlog'
    end
end