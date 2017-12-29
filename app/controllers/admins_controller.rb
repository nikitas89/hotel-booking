class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def show
  end

  def index
    @admins = Admin.all

  end

  def new
    @admin = Admin.new
  end

  def edit
  end

  def create
    @admin = Admin.new(admin_params)
    respond_to do |format|
      if @admin.save
        format.html { redirect_to index, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: index }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def update
  end
end
