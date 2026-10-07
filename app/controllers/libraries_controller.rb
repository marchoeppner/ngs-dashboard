class LibrariesController < ApplicationController
  before_action :set_library, only: %i[ show edit update destroy ]

  before_action :require_admin, only: [ :destroy ]

  # GET /libraries or /libraries.json
  def index
    if params[:search]
        @libraries = Library.where("name LIKE ?", params[:search]).page params[:page]
    else
        @libraries = Library.order(created_at: :desc).page params[:page]
    end
  end

  # GET /libraries/1 or /libraries/1.json
  def show
  end

  # GET /libraries/new
  def new
    @library = Library.new
  end

  # GET /libraries/1/edit
  def edit
  end

  # POST /libraries or /libraries.json
  def create
    @library = Library.new(library_params)

    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: "Library was successfully created." }
        format.json { render :show, status: :created, location: @library }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @library.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /libraries/1 or /libraries/1.json
  def update
    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to @library, notice: "Library was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @library }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @library.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /libraries/1 or /libraries/1.json
  def destroy
    @library.destroy!

    respond_to do |format|
      format.html { redirect_to libraries_path, notice: "Library was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def library_params
      params.expect(library: [ :accession, :name, :platform_id, :run_id, :read_count, :read_length, :q30 ])
    end
end
