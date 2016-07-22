class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @children = Child.where(father:@person)
    if @children.empty?
      @children = Child.where(mother:@person)
    end

    @father = @person.fathers
    @mother = @person.mothers
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
    @parent = Person.all
  end

  # POST /people
  # POST /people.json
  def create_parent
    @person = Person.find(params[:id])
    father = params[:father_id]
    mother = params[:mother_id]
    if father != '' || mother != ''      
      child = Person.find(params[:id])
      parents = Child.find_or_create_by(person:child)
      if father != ''
        father = Person.find(father)
        valor1 = parents.update(father:father)
      end
      if mother != ''
        mother = Person.find(mother)
        valor2 = parents.update(mother:mother)
      end
    end
    respond_to do |format|
    format.html { redirect_to @person, notice: 'Relatión of Parents was successfully created.' }
    end
  end

  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_parent
    @person = Person.find(params[:id])
    @person.children.destroy_all
    respond_to do |format|
    format.html { redirect_to people_path, notice: 'Relación of Parents was successfully destroyed.' }
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name)
    end
end
