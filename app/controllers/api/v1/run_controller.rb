module Api
    module V1
        class RunController < ApiController
            def index
                @runs = Run.all
                render json: @runs
            end

            def show
                @run = Run.find(params[:id])
                render json: @run
            end

            def update
                @run = Run.find(params[:id])

                if @run.update(job_params)
                    render json: @run, status: :ok
                else
                    # Liefert Validierungsfehler (z. B. wenn Felder fehlen) mit Status 422 zurück
                    render json: { errors: @run.errors.full_messages }, status: :unprocessable_entity
                end
            end

            private

            # Strong Parameters: Erlaubt nur die explizit genannten Felder
            def job_params
                params.require(:job).permit(:id, :qc_json)
            end
        end
    end
end
