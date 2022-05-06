defmodule PetClinicWeb.ScheduleController do
  use PetClinicWeb, :controller
  alias PetClinic.AppointmentService.AppointmentService

  def index(conn, %{"id_health_expert" => id, "schedule" => schedule}) do
    schedules = AppointmentService.get_appointment(id, schedule)
    render(conn, "index.html", schedule: schedules)
  end
end
