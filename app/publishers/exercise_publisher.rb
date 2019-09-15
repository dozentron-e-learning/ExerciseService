class ExercisePublisher < ActiveBunny::Publisher
  def create(exercise)
    Rails.logger.info "Send Message about new Exercise: #{exercise.id.to_s}"
    publish({
        id: exercise.id.to_s,
        validation_token: exercise.token,
        plugin: exercise.plugin
    }.to_json)
  end
end