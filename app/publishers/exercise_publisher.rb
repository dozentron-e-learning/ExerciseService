class ExercisePublisher < ActiveBunny::Publisher
  def create(exercise)
    #TODO Generate token to use in controller
    publish({id: exercise.id.to_s, validation_token: ""}.to_json)
  end
end