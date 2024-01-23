class CoachingSession < ApplicationRecord
    self.table_name = 'sessions'

    validates :coach_hash_id, :client_hash_id, :start, :duration, presence: true
    validate :validate_no_overlap_scheduled 

    def validate_no_overlap_scheduled
        return if start.nil? || duration.nil?
        end_time = (start + duration.minutes).strftime('%Y-%m-%d %H:%M:%S')
        overlapping_sessions = CoachingSession.where(coach_hash_id: coach_hash_id)
        .where("start < ? AND ? < datetime(start, '+' || duration || ' minutes')", end_time, start.strftime('%Y-%m-%d %H:%M:%S'))

    
        errors.add(:base, "Session overlaps with another booking") if overlapping_sessions.exists?
    end


end
