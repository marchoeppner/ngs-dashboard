class RunsController < ApplicationController
  # GET /runs or /runs.json
  def index
    @runs = Run.order(created_at: :desc).page params[:page]
    @pipelines = Pipeline.where(run_level: true)
  end

  # GET /runs/1 or /runs/1.json
  def show
    @run = Run.find(params[:id])
    @jobs = @run.jobs
  end

  # GET /runs/new
  def new
    @run = Run.new
  end

  # GET /runs/1/edit
  def edit
    @run = Run.find(params[:id])
  end

  def create_job
    @run = Run.find(params["id"])
    @pipeline = Pipeline.find(params["pipeline_id"])
    @work_dir = Rails.configuration.local_resources["work_dir"]
    @pipeline_profile = Rails.configuration.local_resources["pipeline_profile"]
    user = Current.user

    job = Job.where(run_id: @run.id, pipeline_id: @pipeline.id).first

    if job.nil?

      command = "#{@pipeline['template']} -profile #{@pipeline_profile} -r #{@pipeline.version} --run_name #{@run.name}"
      this_date = Time.now.strftime("%d-%m-%Y")

      wpath = "#{@work_dir}/#{@run.clean_name}_#{@run.id}/#{@pipeline.clean_name}/#{this_date}"
      FileUtils.mkdir_p(wpath)

      if @pipeline.samplesheet_format
        rows = [ @pipeline.samplesheet_format ]
        @run.libraries.each do |lib|
          if @pipeline.samplesheet_format.include?("platform")
            rows << [ lib.name, @run.platform.upcase, lib.R1, lib.R2 ]
          else
            rows << [ lib.name, lib.R1, lib.R2 ]
          end
        end
        ss_name = "#{wpath}/samples.tsv"
        ss = File.new(ss_name, "w+")
        rows.each { |r| ss.puts r }
        ss.close
        command = "#{command} --input samples.tsv"
      else
        command = "#{command} --input #{@run.location}"
      end

      puts command.inspect

      job = Job.create({ run_id: @run.id, pipeline_id: @pipeline.id, command: command, status: "created", run_path: wpath, user_id: user.id })
      puts job.inspect
    end

    respond_to do |format|
      if job && job.save
        format.html { redirect_to @run, notice: "Job #{job.id} successfully created." }
        format.json { render :show, status: :created, location: @run }
      else
        format.html { redirect_to @run, notice: "Job could not be created - maybe it already exists?" }
        format.json { render json. job.errors, status: :unprocessable_content }
      end
    end
  end

  def create_bulk
    @run = Run.find(params[:id])
    @work_dir = Rails.configuration.local_resources["work_dir"]
    @pipeline_profile = Rails.configuration.local_resources["pipeline_profile"]

    user = Current.user

    pipeline = Pipeline.find(params["pipeline"])

    job = nil

    if !Job.where(run_id: @run.id, pipeline_id: pipeline.id).empty?
      # nothing to do here
    else

      libraries = params["libs"].map { |lid| Library.find(lid) }

      command = "#{pipeline['template']} -profile #{@pipeline_profile} -r #{pipeline.version} --run_name #{@run.name} -resume"

      this_date = Time.now.strftime("%d-%m-%Y")

      wpath = "#{@work_dir}/#{@run.clean_name}_#{@run.id}/#{pipeline.clean_name}/#{this_date}"

      FileUtils.mkdir_p(wpath)

      rows = [ pipeline.samplesheet_format ]
      libraries.each do |lib|
        lib_name = lib.name.gsub(/_S[0-9]+$.*/, "")
        if pipeline.samplesheet_format.include?("platform")
          rows << [ lib_name, @run.platform.name.upcase, lib.R1, lib.R2 ].join("\t")
        else
          rows << [ lib_name, lib.R1, lib.R2 ].join("\t")
        end
      end
      ss_name = "#{wpath}/samples.tsv"
      ss = File.new(ss_name, "w+")
      rows.each { |r| ss.puts r }
      ss.close

      command = "#{command} --input samples.tsv"

      job = Job.create({ job_id: nil, run_path: wpath, user_id: user.id, run_id: @run.id, pipeline_id: pipeline.id, command: command, status: "created" })

      libraries.each do |lib|
        xref = XrefJobLibrary.create({ job_id: job.id, library_id: lib.id })
      end

    end

    respond_to do |format|
      if job && job.save
        format.html { redirect_to @run, notice: "Job #{job.id} successfully created." }
        format.json { render :show, status: :created, location: @run }
      else
        format.html { redirect_to @run, notice: "Job could not be created - maybe it already exists?" }
        format.json { render json. job.errors, status: :unprocessable_content }
      end
    end
  end


  # POST /runs/register
  def register
    illumina_dirs = Rails.configuration.local_resources["illumina_dirs"]
    puts illumina_dirs.inspect
    counter = 0
    platform = Platform.first
    illumina_dirs.each do |dir|
      run_dirs = Dir["#{dir}/*_*"]
      run_dirs.each do |rdir|
        name = File.basename(rdir)
        run_date = File.mtime(rdir).strftime("%F")
        run = Run.find_by_name(name)
        if !run
          run = Run.create({ "location" => rdir, "platform" => platform, "name" => name, "run_date" => run_date, "demuxed" => true })
          run.register_libraries
          counter += 1
        end
      end
    end

    redirect_to runs_path, notice: "Added #{counter} runs!"
  end

  # POST /runs or /runs.json
  def create
    @run = Run.new(run_params)

    respond_to do |format|
      if @run.save
        format.html { redirect_to @run, notice: "Run was successfully created." }
        format.json { render :show, status: :created, location: @run }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @run.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /runs/1 or /runs/1.json
  def update
    @run = Run.find(params["id"])
    respond_to do |format|
      if @run.update(run_params)
        format.html { redirect_to @run, notice: "Run was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @run }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @run.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /runs/1 or /runs/1.json
  def destroy
    @run = Run.find(params[:id])
    @run.destroy!

    respond_to do |format|
      format.html { redirect_to runs_path, notice: "Run was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = Run.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def run_params
      params.expect(run: [ :platform_id, :location, :name, :run_date, :demuxed, :comments ])
    end
end
