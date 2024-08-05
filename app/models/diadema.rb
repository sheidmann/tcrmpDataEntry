class Diadema < ApplicationRecord
	validates_presence_of :fish_transect

	belongs_to :fish_transect
  accepts_nested_attributes_for :fish_transect

  def self.as_csv
    columns = %w(fish_transect_id site_name date_completed name rep notes test_size_cm)
    CSV.generate(headers: true) do |csv|
      csv << columns.map(&:humanize)
      all.each do |diadema|
        fish_transect = diadema.fish_transect
        site = fish_transect.site
        user = fish_transect.user
        csv << fish_transect.attributes.merge(site.attributes).merge(user.attributes).merge(diadema.attributes).values_at(*columns)
      end
    end
  end
end
