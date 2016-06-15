#encoding: utf-8
require 'open-uri'

class OverPlatformsController < ApplicationController
  before_action :set_over_platform, only: [:show, :edit, :update, :destroy]

  # GET /over_platforms
  # GET /over_platforms.json
  def index
    @over_platforms = OverPlatform.all
  end

  # GET /over_platforms/1
  # GET /over_platforms/1.json
  def show
  end

  # GET /over_platforms/new
  def new
    @over_platform = OverPlatform.new
  end

  # GET /over_platforms/1/edit
  def edit
  end

  # POST /over_platforms
  # POST /over_platforms.json
  def create
    @over_platform = OverPlatform.new(over_platform_params)

    respond_to do |format|
      if @over_platform.save
        format.html { redirect_to @over_platform, notice: 'Over platform was successfully created.' }
        format.json { render :show, status: :created, location: @over_platform }
      else
        format.html { render :new }
        format.json { render json: @over_platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /over_platforms/1
  # PATCH/PUT /over_platforms/1.json
  def update
    respond_to do |format|
      if @over_platform.update(over_platform_params)
        format.html { redirect_to @over_platform, notice: 'Over platform was successfully updated.' }
        format.json { render :show, status: :ok, location: @over_platform }
      else
        format.html { render :edit }
        format.json { render json: @over_platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /over_platforms/1
  # DELETE /over_platforms/1.json
  def destroy
    @over_platform.destroy
    respond_to do |format|
      format.html { redirect_to over_platforms_url, notice: 'Over platform was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_over_platform
      @over_platform = OverPlatform.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def over_platform_params
      params.fetch(:over_platform, {})
    end
end
