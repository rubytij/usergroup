class Event < ActiveRecord::Base
  belongs_to :user

  validates :name, :user, :description, :presence => true
  validate  :time_span

  attr_accessible :name, :starts_at, :ends_at, :description, :user, :user_id

  private
  def time_span
    errors.add(:starts_at, I18n.t("activerecord.errors.events.starts_at_greater")) unless self.ends_at > self.starts_at
  end
end
