class Event < ActiveRecord::Base
  belongs_to :user

  validates :name, :user, :description, :presence => true
  validate  :time_span

  attr_accessible :name, :start_date, :end_date, :description, :user, :user_id

  private
  def time_span
    errors.add(:start_date, I18n.t("activerecord.errors.events.starts_at_greater")) unless self.end_date > self.start_date
  end
end
