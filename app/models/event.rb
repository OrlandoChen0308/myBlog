class Event < ActiveRecord::Base
	 has_one :stat
	 before_create :build_default_stat

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
