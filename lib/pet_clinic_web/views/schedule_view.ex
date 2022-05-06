defmodule PetClinicWeb.ScheduleView do
  use PetClinicWeb, :view

  def get_expert_name(schedule) do
    schedule.name
  end

  def get_hour(date) do
    NaiveDateTime.to_time(date)
  end
end
