class Api::V1::Exercise
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include ServiceTokenConcern

  # The day it should be visible is somewhere between long ago and now :D
  scope :visible, -> { where(visible_date: DateTime.new..DateTime.now) }

  after_create do |obj|
    obj.update_attribute(:token, service_token("#{obj.plugin}_Exercise_Validation", "ExerciseService", {
        exercise_id: obj.id.to_s,
        scope: [
            :validation
        ]
    }))
    ExercisePublisher.new.create obj
  end

  attr_accessor :auth_token

  VALIDATION_NOT_PERFORMED = :not_performed
  VALIDATION_SUCCEEDED = :success
  VALIDATION_FAILED = :failed

  STRONG_PARAMETERS = %i[
    title
    description
    deadline
    visible_date
    do_plagiarism_check
    plugin
    exercise_test
    exercise_hidden_test
    exercise_stub
  ].freeze

  # can't add tests because it needs to be added as tests: {}
  # for it to allow the hash
  STRONG_PARAMETERS_VALIDATION = %i[
    validation_status
    test_validation_error
    hidden_test_validation_error
    stub_validation_error
    general_validation_error
    general_validation_error_details
  ].freeze

  mount_uploader :exercise_test, ExerciseUploader
  mount_uploader :exercise_hidden_test, ExerciseUploader
  mount_uploader :exercise_stub, ExerciseUploader

  field :token, type: String

  field :creator, type: String

  field :title, type: String
  field :description, type: String
  field :deadline, type: Date
  field :visible_date, type: Date
  field :do_plagiarism_check, type: Boolean, default: false
  field :plugin, type: String
  field :tests, type: Hash, default: {}
  field :validation_status, type: Symbol, default: VALIDATION_NOT_PERFORMED
  field :test_validation_error, type: String
  field :hidden_test_validation_error, type: String
  field :stub_validation_error, type: String
  field :general_validation_error, type: String
  field :general_validation_error_details, type: String

  validates :creator, presence: true
  validates :title, length: { minimum: 1 }
  validates :exercise_test, presence: true
  validates :plugin, presence: true
end
