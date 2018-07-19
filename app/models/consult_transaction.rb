class ConsultTransaction < ApplicationRecord

  after_create :build_chat, :create_open_tok_session
  after_destroy :destroy_chat

  enum status: [:initiated, :confirmed, :payment_pending, :payment_completed, :canceled, :completed, :aborted, :student_reviewed, :instructor_reviewed, :reviewed]

  belongs_to :instructor, class_name: 'InstructorInfo'
  belongs_to :student, class_name: 'UserInfo'

  has_one :chat
  has_one :payment, as: :payable
  has_many :reviews, dependent: :destroy

  validates_presence_of :instructor_id
  validates_presence_of :student_id
  validate do
    errors.add(:base, "Consulting yourself is not allowed") if instructor_id == student_id
  end

  # this function is to access .yml to get corresponding CHINESE/ENGLISH based on status enum
  def self.status_enum_name(enum_name)
     I18n.t("activerecord.attributes.consult_transaction.status.#{enum_name.to_s}")
  end

  def student_review
    self.reviews.where(reviewer_id: self.student_id).first
  end

  def instructor_review
    self.reviews.where(reviewer_id: self.instructor_id).first
  end

  def student_review_rating
    self.reviews.where(reviewer_id: self.student_id).first.try(:avg_rate)
  end

  def instructor_review_rating
    self.reviews.where(reviewer_id: self.instructor_id).first.try(:avg_rate)
  end

  def payment_completed!
    self.confirmed!
  end

  def generate_opentok_token
    create_open_tok_session if open_tok_session_id.nil?
    opentok.generate_token self.open_tok_session_id
  end

  def payment_amount
    #TODO update the logic to calculate the price.
    # transaction.instructor.fix_price? ? transaction.instructor.max_price : transaction.instructor.max_price
    instructor = self.instructor
    price = case self.service
      when "early_consult"
        instructor.consult_fix_price? ? instructor.consult_fix_price : instructor.consult_min_price
      when "brainstorm_consultant"
        instructor.brainstorm_fix_price? ? instructor.brainstorm_fix_price : instructor.brainstorm_min_price
      when "essay_consultant"
        instructor.essay_fix_price? ? instructor.essay_fix_price : instructor.essay_min_price
      when "visa_consultant"
        instructor.visa_fix_price? ? instructor.visa_fix_price : instructor.visa_min_price
      when "all"
        600
      when ""
        1
      when nil
        1
    end
    self.hourly_price || price
  end

  private

  def opentok
    @opentok ||= OpenTok::OpenTok.new Rails.application.secrets.tokbox[:api_key], Rails.application.secrets.tokbox[:secret]
  end

  def build_chat
    Chat.create(consult_transaction_id: self.id)
  end

  def destroy_chat
    Chat.destroy(consult_transaction_id: self.id)
  end

  def create_open_tok_session
    session = opentok.create_session :media_mode => :routed
    self.open_tok_session_id = session.session_id
    self.save
  end

end
