class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[ show edit update destroy ]

  def obtener_status
  end

  # GET /projects or /projects.json
  def index
    @estado_projecto = Hash.new()
    @projects = current_user.projects
    @projectos = current_user.projects

    @projectos.each do |projecto|
      @test = projecto.tasks
      @estados = Hash.new()
      @test.each do |task|
        @estados.merge!({ task.id => task.status })
      end
      if not(@estados.value?("in-progress") || @estados.value?("no-started"))
        @estado_projecto.merge!({ projecto.id => "completed" })
      elsif not(@estados.value?("in-progress") || @estados.value?("completed"))
        @estado_projecto.merge!({ projecto.id => "no-started" })
      else
        @estado_projecto.merge!({ projecto.id => "in-progress" })
      end
    end
  end

  # GET /projects/1 or /projects/1.json
  def show
    @task = @project.tasks.build
    @test = @project.tasks
    @estados = Hash.new()
    @test.each do |task|
      @estados.merge!({ task.id => task.status })
    end
    if not(@estados.value?("in-progress") || @estados.value?("no-started"))
      @estado_projecto = "completed"
    elsif not(@estados.value?("in-progress") || @estados.value?("completed"))
      @estado_projecto = "no-started"
    else
      @estado_projecto = "in-progress"
    end
  end

  # GET /projects/new
  def new
    @project = current_user.projects.build
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = current_user.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = current_user.projects.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :description)
  end
end
