class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    
    def index
        render json: Camper.all
    end

    def show
        camper = find_camper
        render json: camper, serializer: CamperWithActivitiesSerializer
    end

    def create
        camper = Camper.create(camper_params)
        if camper.valid?
            render json: camper, status: :created
        else
            render json: {errors: camper.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def find_camper
        Camper.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end
end
