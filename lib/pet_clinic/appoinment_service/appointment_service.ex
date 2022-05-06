defmodule PetClinic.AppointmentService.AppointmentService do
  alias PetClinic.Repo
  alias PetClinic.PetHealthExpert.Vet
  alias PetClinic.AppoinmentService.ExpertSchedule
  alias PetClinic.PetClinicService.Pet
  alias PetClinic.AppoinmentService.Appointments
  import Ecto.Changeset
  import Ecto.Query

  def available_slots(id, from_date, to_date) do
    cond do
      Date.compare(from_date, to_date) == :gt ->
        {:error, "wrong date range"}

      Date.compare(from_date, NaiveDateTime.to_date(NaiveDateTime.utc_now())) == :lt ->
        {:error, "datetime is in the past"}

      Date.compare(to_date, NaiveDateTime.to_date(NaiveDateTime.utc_now())) == :lt ->
        {:error, "datetime is in the past"}

      Date.compare(from_date, to_date) == :eq ->
        expert = Repo.one(from e in ExpertSchedule, where: e.health_expert_id == ^id)
        range = date_range(from_date, to_date)
        days = transform_to_day(range)
        days_hours = schedule(expert, days)
        filter = filter(days_hours, range)

        available =
          Enum.map(filter, fn f -> %{Enum.at(f, 2) => [Enum.at(f, 0), Enum.at(f, 1)]} end)
          |> Enum.map(fn date ->
            Enum.map(date, fn {k, v} -> %{k => time_range(List.first(v), List.last(v))} end)
          end)
          |> List.flatten()

      Date.compare(from_date, to_date) == :lt ->
        expert = Repo.one(from e in ExpertSchedule, where: e.health_expert_id == ^id)
        range = date_range(from_date, to_date)
        days = transform_to_day(range)
        days_hours = schedule(expert, days)
        filter = filter(days_hours, range)

        available =
          Enum.map(filter, fn f -> %{Enum.at(f, 2) => [Enum.at(f, 0), Enum.at(f, 1)]} end)
          |> Enum.map(fn date ->
            Enum.map(date, fn {k, v} -> %{k => time_range(List.first(v), List.last(v))} end)
          end)
          |> List.flatten()
    end
  end

  def new_appointmen(id_expert, id_pet, timedate) do
    date = NaiveDateTime.to_date(timedate)
    time = NaiveDateTime.to_time(timedate)

    cond do
      Repo.get_by(ExpertSchedule, health_expert_id: id_expert) == nil ->
        {:error, "No expert id"}

      Repo.get_by(ExpertSchedule, health_expert_id: id_expert) != nil ->
        cond do
          Repo.get_by(Pet, id: id_pet) == nil ->
            {:error, "No pet dont exist"}

          Repo.get_by(Pet, id: id_pet) != nil ->
            slots = available_slots(id_expert, date, date)

            is_there =
              Enum.map(slots, fn slot ->
                slot[date]
                |> Enum.map(fn hour -> Time.truncate(hour, :second) end)
                |> Enum.member?(time)
              end)
              |> Enum.member?(true)

            cond do
              is_there == true ->
                chset = %Appointments{
                  health_expert_id: id_expert,
                  pet_id: id_pet,
                  date_time: timedate
                }

                Repo.insert(chset)

              is_there == false ->
                {:error, "NO hour for this day"}
            end
        end
    end
  end

  def date_range(from_date, to_date) do
    range = Date.range(from_date, to_date)
    Enum.take(range, Enum.count(range))
  end

  def transform_to_day(range) do
    Enum.map(range, fn date -> Date.day_of_week(date) end)
  end

  def schedule(expert, days) do
    Enum.map(days, fn day ->
      cond do
        day == 1 -> [expert.monday_start, expert.monday_end]
        day == 2 -> [expert.tuesday_start, expert.tuesday_end]
        day == 3 -> [expert.wednesday_start, expert.wednesday_end]
        day == 4 -> [expert.thursday_start, expert.thursday_end]
        day == 5 -> [expert.friday_start, expert.friday_end]
        day == 6 -> [expert.saturday_start, expert.saturday_end]
        day == 7 -> [expert.sunday_start, expert.sunday_end]
      end
    end)
  end

  def filter(schedule, range) do
    Enum.zip(schedule, range)
    |> Enum.map(fn t -> Tuple.to_list(t) end)
    |> List.flatten()
    |> Enum.chunk_every(3)
    |> Enum.map(fn x -> List.delete(x, nil) end)
    |> Enum.filter(fn x -> length(x) > 2 end)
  end

  def time_range(init_time, end_time) do
    case Time.compare(init_time, end_time) do
      :gt ->
        []

      :eq ->
        [init_time]

      # recursion para crear los rangos de media hora
      :lt ->
        rec = Time.add(init_time, 1800)
        [init_time | time_range(rec, end_time)]
    end
  end

  def get_appointment(id, schedule) do
    vet =
      Vet
      |> where([v], v.id == ^id)
      |> preload([appoinments: [pets: [:pet_type, :owner]]])
      |> Repo.one()
      |> filter_appointments(schedule)
  end

  defp filter_appointments(vet, schedule) do
    {:ok, date} = Date.from_iso8601(schedule)
    {:ok, start_date} = NaiveDateTime.new(date, ~T[00:00:00])
    {:ok, end_date} = NaiveDateTime.new(date, ~T[23:59:59])

    appointments =
      Enum.filter(vet.appoinments, fn appointment ->
        appointment.date_time < end_date && appointment.date_time > start_date
      end)

    Map.replace!(vet, :appoinments, appointments)

  end
end
