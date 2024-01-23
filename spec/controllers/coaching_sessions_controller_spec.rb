require 'rails_helper'

RSpec.describe CoachingSessionsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          coach_hash_id: 'coach123',
          client_hash_id: 'client123',
          start: DateTime.now + 1.day,
          duration: 60
        }
      end

      it 'creates a new coaching session and returns a created status' do
        post :create, params: { coaching_session: valid_params }
        expect(response).to have_http_status(:created)
        expect(CoachingSession.last.coach_hash_id).to eq('coach123')
      end
    end

    context 'with invalid parameters' do
      it 'returns an unprocessable entity status' do
        post :create, params: { coaching_session: { coach_hash_id: nil, client_hash_id: nil, start: nil, duration: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with missing parameters' do
      it 'returns an unprocessable entity status' do
        post :create, params: {}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    
    context 'with overlapping session times' do
        before do
            @coach_id = 'coach123'
            @client_id = 'client123'
            @start_time = DateTime.now + 1.day
            CoachingSession.create!(coach_hash_id: @coach_id, client_hash_id: @client_id, start: @start_time, duration: 60)
        end

        let(:overlapping_session_params) do
        {
            coach_hash_id: @coach_id,
            client_hash_id: 'client456',
            start: @start_time + 30.minutes, # Overlapping time
            duration: 60
        }
        end

        it 'does not create a session and returns an unprocessable entity status' do
            post :create, params: { coaching_session: overlapping_session_params }
            expect(response).to have_http_status(:unprocessable_entity)
            expect(CoachingSession.where(coach_hash_id: @coach_id, start: @start_time + 30.minutes).count).to eq(0)
        end
    end
  end
end
