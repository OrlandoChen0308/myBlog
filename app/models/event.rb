class Event < ActiveRecord::Base
	 has_one :stat
	 before_create :build_default_stat

def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    all.each do |event|
      csv << event.attributes.values_at(*column_names)
    end
  end
end

def self.import(file)
  CSV.foreach(file.path, headers: true) do |row|
    event = find_by_id(row["id"]) || new
    event.attributes = row.to_hash.slice(*row.to_hash.keys)
    event.save!
  end
end

# def self.import(file)
#   spreadsheet = open_spreadsheet(file)
#   header = spreadsheet.row(1)
#   (2..spreadsheet.last_row).each do |i|
#     row = Hash[[header, spreadsheet.row(i)].transpose]
#     event = find_by_id(row["id"]) || new
#     event.attributes = row.to_hash.slice(*accessible_attributes)
#     event.save!
#   end
# end

# def self.open_spreadsheet(file)
#   case File.extname(file.original_filename)
#   when ".csv" then Csv.new(file.path, nil, :ignore)
#   when ".xls" then Excel.new(file.path, nil, :ignore)
#   when ".xlsx" then Excelx.new(file.path, nil, :ignore)
#   else raise "Unknown file type: #{file.original_filename}"
#   end
# end

	private
	def build_default_stat
  # build default profile instance. Will use default params.
  # The foreign key to the owning User model is set automatically
  	build_stat(:status => false)
  	true # Always return true in callbacks as the normal 'continue' state
       # Assumes that the default_profile can **always** be created.
       # or
       # Check the validation of the profile. If it is not valid, then
       # return false from the callback. Best to use a before_validation 
       # if doing this. View code should check the errors of the child.
       # Or add the child's errors to the User model's error array of the :base
       # error item
	end
end
