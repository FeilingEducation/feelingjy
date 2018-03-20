class TutorMailer < ApplicationMailer
	def notify_tutor(tutor_id, student_id)
		@tutor = User.find(tutor_id)
		@student = User.find(student_id)
		mail( :to => @tutor.email, :subject => 'Someone need your service.' )
	end
end
