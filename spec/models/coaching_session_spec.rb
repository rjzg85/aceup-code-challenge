require 'rails_helper'

RSpec.describe CoachingSession, type: :model do
  let(:default_attributes) do
    {
      coach_hash_id: 'default_coach',
      client_hash_id: 'default_client',
      start: DateTime.now + 1.day,
      duration: 60
    }
  end

  it 'is invalid without a coach_hash_id' do
    session = CoachingSession.new(default_attributes.merge(coach_hash_id: nil))
    expect(session).not_to be_valid
  end

  it 'is invalid without a client_hash_id' do
    session = CoachingSession.new(default_attributes.merge(client_hash_id: nil))
    expect(session).not_to be_valid
  end

  it 'is invalid without a start time' do
    session = CoachingSession.new(default_attributes.merge(start: nil))
    expect(session).not_to be_valid
  end

  it 'is invalid without a duration' do
    session = CoachingSession.new(default_attributes.merge(duration: nil))
    expect(session).not_to be_valid
  end

  describe 'validate_no_overlap_scheduled' do
    let(:coach_id) { '12345' }
    let(:start_time) { DateTime.now + 1.day }
    
    before do
      CoachingSession.create!(default_attributes.merge(coach_hash_id: coach_id, start: start_time))
    end

    it 'is invalid with an overlapping session' do
      overlapping_session = CoachingSession.new(default_attributes.merge(coach_hash_id: coach_id, start: start_time + 30.minutes))
      expect(overlapping_session).not_to be_valid
    end

    it 'is valid with a non-overlapping session' do
      non_overlapping_session = CoachingSession.new(default_attributes.merge(coach_hash_id: coach_id, start: start_time + 1.hour))
      expect(non_overlapping_session).to be_valid
    end
  end
end
