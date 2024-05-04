class TimeEntryBulkCreator
  include ActiveModel::Model

  attr_accessor :start_date, :end_date, :start_time, :end_time, :project_id, :task_id

  validates :start_date, :end_date, :start_time, :end_time, :project_id, :task_id, presence: true
  validates_comparison_of :start_date, less_than: -> (record) { record.end_date }, message: "must be before end date"
  validates_comparison_of :start_time, less_than: -> (record) { record.end_time }, message: "must be before end time"

  def initialize(args = {})
    args[:start_date] ||= Date.today
    args[:start_time] ||= Time.new(2000, 1, 1, 9, 0)
    args[:end_time]   ||= Time.new(2000, 1, 1, 17, 0)
    args[:project_id] ||= 32294801
    args[:task_id]    ||= 18476820
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def send(current_user)
    return nil unless valid?
    result = []
    date_range.each do |date|
      next if date.saturday? || date.sunday?
      response = HTTParty.post("https://api.harvestapp.com/v2/time_entries",
        headers: current_user[:headers],
        body: {
          "user_id": current_user[:user_id],
          "project_id": project_id,
          "task_id": task_id,
          "spent_date": date.strftime("%F"),
          "started_time": Time.parse(start_time).strftime("%-l:%M%P"),
          "ended_time": Time.parse(end_time).strftime("%-l:%M%P"),
        }.to_json
      )
      result << project_id + ' ' + task_id + ' ' + date.strftime("%F") + ' ' + Time.parse(start_time).strftime("%-l:%M%P") + ' ' + Time.parse(end_time).strftime("%-l:%M%P")
      sleep 0.5
    end
    result
  end

  private

  def date_range
    Date.parse(start_date)..Date.parse(end_date)
  end
end
