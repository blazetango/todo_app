class Task < ActiveRecord::Base
	belongs_to :user
	scope :completed, -> (user_id) { where(completed: true, user_id: user_id) }
	scope :not_completed, -> (user_id) { where(completed: nil, user_id: user_id) }  

	def mark_complete
		self.completed = true
		self.save
	end

	def mark_incomplete
		self.completed = nil
		self.save
	end

end
