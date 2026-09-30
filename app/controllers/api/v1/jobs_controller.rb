module Api
    module V1
        class JobsController < ApiController
            def index
                @jobs = Job.all
                render json: @jobs
            end

            def show
                @job = Job.find(params[:id])
                render json: @job
            end

            def update
                @job = Job.find(params[:id])

                if @job.update(job_params)
                    render json: @job, status: :ok
                else
                    # Liefert Validierungsfehler (z. B. wenn Felder fehlen) mit Status 422 zurück
                    render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
                end
            end

            private

            # Strong Parameters: Erlaubt nur die explizit genannten Felder
            def job_params
                params.require(:job).permit(:job_id, :status)
            end
        end
    end
end
