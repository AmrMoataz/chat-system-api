require 'securerandom'
module Api
	module V1
		class ApplicationsController < Api::V1::BaseController
			def create
				data = params[:application];
				@application = Application.new(application_params)
				@application.token = SecureRandom.uuid
				if @application.save
					render json: {
						"success": true,
						"data": @application.as_json(:except => [:id])
					}
				else
					render json: {
						"success": false,
						"errors": @application.errors.full_messages
					}
				end
			end
		
			def show
				@application = Application.where(:token => [params[:token]]).first
				render json: {
					"success": true,
					"data": @application.as_json(:except => [:id])
				}
			end
		
			def index
				@applcations = Application.all
				render json: {
					"success": true,
					"data": @applcations.as_json(:except => [:id])
				}
			end
		
			def destroy
				@application = Application.where(:token => [params[:token]]).first
				@application.destroy
			end
		
		private
			def application_params
				params.require(:application).permit(:name)
			end
		end
	end
end

