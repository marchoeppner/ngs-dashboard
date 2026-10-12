module Api
    module V1
        class RunsController < ApiController
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
 
                if @run.update(run_params)
                    render json: @run, status: :ok
                else
                    # Liefert Validierungsfehler (z. B. wenn Felder fehlen) mit Status 422 zurück
                    render json: { errors: @run.errors.full_messages }, status: :unprocessable_entity
                end
            end

            private

            # Strong Parameters: Erlaubt nur die explizit genannten Felder
            def run_params
                # 1. Fetch the permitted base fields
                permitted = params.require(:run).permit(:id)

                # 2. Safely extract and convert the full dynamic json structure to a native Hash
                if params[:run][:qc_json].present?
                    # .permit! allows all unknown nested keys inside your NGS report
                    permitted[:qc_json] = params[:run][:qc_json].permit!.to_h
                end

                permitted
            end
        end
    end
end
