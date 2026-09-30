class XrefJobLibrariesController < ApplicationController
  before_action :set_xref_job_library, only: %i[ show edit update destroy ]

  # GET /xref_job_libraries or /xref_job_libraries.json
  def index
    @xref_job_libraries = XrefJobLibrary.all
  end

  # GET /xref_job_libraries/1 or /xref_job_libraries/1.json
  def show
  end

  # GET /xref_job_libraries/new
  def new
    @xref_job_library = XrefJobLibrary.new
  end

  # GET /xref_job_libraries/1/edit
  def edit
  end

  # POST /xref_job_libraries or /xref_job_libraries.json
  def create
    @xref_job_library = XrefJobLibrary.new(xref_job_library_params)

    respond_to do |format|
      if @xref_job_library.save
        format.html { redirect_to @xref_job_library, notice: "Xref job library was successfully created." }
        format.json { render :show, status: :created, location: @xref_job_library }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @xref_job_library.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /xref_job_libraries/1 or /xref_job_libraries/1.json
  def update
    respond_to do |format|
      if @xref_job_library.update(xref_job_library_params)
        format.html { redirect_to @xref_job_library, notice: "Xref job library was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @xref_job_library }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @xref_job_library.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /xref_job_libraries/1 or /xref_job_libraries/1.json
  def destroy
    @xref_job_library.destroy!

    respond_to do |format|
      format.html { redirect_to xref_job_libraries_path, notice: "Xref job library was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_xref_job_library
      @xref_job_library = XrefJobLibrary.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def xref_job_library_params
      params.expect(xref_job_library: [ :job_id, :library_id ])
    end
end
