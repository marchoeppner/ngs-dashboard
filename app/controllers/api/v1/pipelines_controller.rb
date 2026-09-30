module Api
    module V1

        class PipelinesController < ApiController
            def index
                @pipelines = Pipeline.all
                render json: @pipelines
            end

            def show
                @post = Pipeline.find(params[:id])
                render json: @pipeline
            end

        end
    end
end