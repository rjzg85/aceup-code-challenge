class CoachingSessionsController < ApplicationController
    before_action :validate_session_params, only: [:create]

    def create
        session = CoachingSession.new(session_params)
    
        if session.save
          render json: session, status: :created
        else
          render status: :unprocessable_entity
        end
      end
    
    private
    
    def session_params
      params.require(:coaching_session).permit(:coach_hash_id, :client_hash_id, :start, :duration)
    end

    def validate_session_params
        begin
          session_params
        rescue ActionController::ParameterMissing
          render json: { error: 'Missing parameters' }, status: :unprocessable_entity
          return
        end
    
        unless valid_session_params?(session_params)
          render json: { error: 'Invalid parameters' }, status: :unprocessable_entity
          return
        end
    end

    def valid_session_params?(params)
        params[:coach_hash_id].present? && params[:client_hash_id].present? && params[:start].present? && params[:duration].present?
    end

end
