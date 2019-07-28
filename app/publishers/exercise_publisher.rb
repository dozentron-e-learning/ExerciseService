class ExercisePublisher < ActiveBunny::Publisher
  def create(exercise)
    Rails.logger.info "Send Message about new Exercise: #{exercise.id.to_s}"
    #TODO Generate token to use in controller
    publish({id: exercise.id.to_s, validation_token: ""}.to_json)
  end
end