class PoolsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pool, only: [:show, :edit, :update, :destroy]
  before_action :check_permission, only: [:edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /pools
  # GET /pools.json
  def index
    @pools = Pool.order(sort_column + " " + sort_direction)
  end

  # GET /pools/1
  # GET /pools/1.json
  def show
  end

  # GET /pools/new
  def new
    @pool = Pool.new
  end

  # GET /pools/1/edit
  def edit
  end

  # POST /pools
  # POST /pools.json
  def create
    @pool = Pool.new(pool_params)
    @pool.user = current_user

    respond_to do |format|
      if @pool.save
        format.html { redirect_to @pool, notice: 'Pool was successfully created.' }
        format.json { render :show, status: :created, location: @pool }
      else
        format.html { render :new }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pools/1
  # PATCH/PUT /pools/1.json
  def update
    respond_to do |format|
      if @pool.update(pool_params)
        format.html { redirect_to @pool, notice: 'Pool was successfully updated.' }
        format.json { render :show, status: :ok, location: @pool }
      else
        format.html { render :edit }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pools/1
  # DELETE /pools/1.json
  def destroy
    @pool.destroy
    respond_to do |format|
      format.html { redirect_to pools_url, notice: 'Pool was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pool
      @pool = Pool.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pool_params
      params.require(:pool).permit(:name, :contact, :destination, :be_there_at)
    end

    # Only allow the user who created the pool to edit it or delete it
    def correct_user
      current_user.id == @pool.user_id
    end

    def check_permission
      redirect_to pools_path, error: 'You are not authorised to edit/delete this pool' unless correct_user
    end

    def sort_column
      Pool.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
