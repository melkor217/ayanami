class ValidateCountsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Team.where(members_calculated_at: nil).or(Team.where('members_calculated_at < ?', 7.days.ago)).each do |team|
      team.members = team.players.where(hideranking: 0).count
      if team.members_changed?
        logger.warn("Team #{team.clanId} had incorrect count")
      end
      team.members_calculated_at = Time.now
      team.save
    end
  end
end
