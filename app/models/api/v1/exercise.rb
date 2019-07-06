class Api::V1::Exercise
  include Mongoid::Document
  include Mongoid::Paperclip

  VALIDATION_NOT_PERFORMED = :not_performed
  VALIDATION_SUCCEEDED = :succeeded
  VALIDATION_FAILED = :failed

  STRONG_PARAMETERS = %i[
    title
    description
    deadline
    visible_date
    do_plagiarism_check
    exercise_test
    exercise_hidden_test
    exercise_stub
    validation_status
    test_validation_error
    hidden_test_validation_error
    stub_validation_error
    general_validation_error
    general_validation_error_details
  ].freeze

  has_mongoid_attached_file :exercise_test
  has_mongoid_attached_file :exercise_hidden_test
  has_mongoid_attached_file :exercise_stub

  do_not_validate_attachment_file_type :exercise_test
  do_not_validate_attachment_file_type :exercise_hidden_test
  do_not_validate_attachment_file_type :exercise_stub

  field :title, type: String
  field :description, type: String
  field :deadline, type: Date
  field :visible_date, type: Date
  field :do_plagiarism_check, type: Boolean, default: false
  field :validation_status, type: Symbol, default: VALIDATION_NOT_PERFORMED
  field :test_validation_error, type: String
  field :hidden_test_validation_error, type: String
  field :stub_validation_error, type: String
  field :general_validation_error, type: String
  field :general_validation_error_details, type: String

  validates :title, length: { minimum: 1 }
  validates :exercise_test, presence: true

  def visible?
    visible_date.past?
  end
end
