class TutorMailer < ApplicationMailer

	def notify_tutor(tutor_id, student_id)
		@tutor = User.find(tutor_id)
		@student = User.find(student_id)
		mail( :to => @tutor.email, :subject => 'Someone need your service.' )
	end

	def send_message_notification current_user
		puts "\n\n\n\n\n\n******Sending send_message_notification"
		puts current_user.inspect
		mail( :to => current_user.email, :subject => 'Hello!! You have received a new message' )
	end

	def order_confirmation transaction, txn_path
		puts "transaction"
		@txn_path = txn_path
		@student = transaction.student
		@tutor = transaction.instructor
	end

	def order_decline transaction
		puts "transaction"
		@txn_path = txn_path
		@student = transaction.student
		@tutor = transaction.instructor
	end

end
