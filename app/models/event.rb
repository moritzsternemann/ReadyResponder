class Event < ActiveRecord::Base
  before_save :calc_duration

  attr_accessible :title, :description, :category, :course_id, :duration, :start_time, :end_time, :instructor, :location, :status, :timecard_ids, :person_ids, :comments

  validates_presence_of :category, :title, :status

  validates_presence_of :start_time
  # Currently we need an end time to provide proper ranges to the scopes.
  # This will need to be revisited
  validates_presence_of :end_time  #, :if => :completed?
  validates_chronology :start_time, :end_time

  has_many :certs
  belongs_to :course
  has_many :activities, as: :loggable

  has_many :timecards
  has_many :people, :through => :timecards
  has_many :tasks
  has_many :notifications

  accepts_nested_attributes_for :timecards
  accepts_nested_attributes_for :certs

  scope :upcoming, -> { order("start_time ASC").where( status: ["Scheduled", "In-session"] ) }

  CATEGORY_CHOICES = ['Training', 'Patrol', 'Meeting', 'Admin', 'Event', 'Template']
  STATUS_CHOICES = ['Scheduled', 'In-session', 'Completed', 'Cancelled', "Closed"]

  def to_s
    description
  end

  def unavailabilities
    responses.unavailable + partial_responses.unavailable
  end

  def partial_responses
    Availability.partially_available(self.start_time..self.end_time)
  end

  def partial_availabilities
    partial_responses.available
  end

  def partial_respondents
    self.partial_responses.map { |a| a.person }
  end


  def availabilities
    responses.available
  end

  def responses
    Availability.for_time_span(self.start_time..self.end_time)
  end

  def respondents
    self.responses.map { |a| a.person }
  end

  def eligible_people
    Person.active.all # In the future, this will need to honor department
    # def eligible_people
    #   self.departments.each do |department|
    #
    #   end
    # end
  end

  def unresponsive_people
    eligible_people - respondents - partial_respondents
  end

  def manhours
    self.timecards.sum('actual_duration')
  end

  def scheduled_people
    # TODO In the pr that add Assignments, this will need to changes
    # Something like assignments.people.unique
    self.timecards.scheduled
  end

  def completed?
    status == "Completed"
  end

  def schedule(schedulable, schedule_action, timecard = Timecard.new )
    # TODO This is probably now deprecated. PR for assignments should remove this
    @card = timecard
    @card.person = schedulable if schedulable.class.name == "Person"
    @card.event = self
    case schedule_action
      when "Available", "Scheduled", "Unavailable"
        @card.intention = schedule_action
        @card.intended_start_time = self.start_time
        @card.intended_end_time = self.end_time
      when "Worked"
        @card.outcome = schedule_action
        @card.actual_start_time = self.start_time
        @card.actual_end_time = self.end_time
    end
    @card.save
    return @card
  end

  def ready_to_schedule?(schedule_action)
    return false if self.nil?
    return false if schedule_action.blank?
    return false if self.status.blank?
    return false if self.status == "Closed"

    case schedule_action
      when "Available", "Scheduled", "Unavailable"
        return false if self.start_time.blank?
      when "Worked"
        return false if self.start_time.blank? or self.end_time.blank?
    end
    return true
  end

private
  def calc_duration #This is also used in timecards; it should be extracted out
     if !(start_time.blank?) and !(end_time.blank?)
      self.duration = ((end_time - start_time) / 1.hour).round(2) || 0
    end
  end
end
