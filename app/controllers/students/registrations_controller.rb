class Students::RegistrationsController < Devise::RegistrationsController
  before_filter :get_lessons

  def update
  # no mass assignment for country_id, we do it manually
  # check for existence of the lesson in case a malicious student manipulates the params (fails silently)
  if params[resource_name][:lesson_id]
    resource.lesson_id = params[resource_name][:lesson_id] if Lesson.find_by_id(params[resource_name][:lesson_id])
  end
  super
end

private
  def get_lessons
    @all_lessons = Lesson.all
    @lessons = []
    @all_lessons.each do |c|
      @lessons.push([c.name, c.id])
    end
  end
end
