#encoding: utf-8
require 'open-uri'

class OverProfilesController < ApplicationController
  before_action :set_over_profile, only: [:show, :edit, :update, :destroy]

  # GET /over_profiles
  # GET /over_profiles.json
  def index
    @over_profiles = OverProfile.all
  end

  # GET /over_profiles/1
  # GET /over_profiles/1.json
  def show
  end

  # GET /over_profiles/new
  def new
    @over_profile = OverProfile.new
  end

  # GET /over_profiles/1/edit
  def edit
  end

  # POST /over_profiles
  # POST /over_profiles.json
  def create
    @over_profile = OverProfile.new(over_profile_params)

    respond_to do |format|
      if @over_profile.save
        format.html { redirect_to @over_profile, notice: 'Over profile was successfully created.' }
        format.json { render :show, status: :created, location: @over_profile }
      else
        format.html { render :new }
        format.json { render json: @over_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /over_profiles/1
  # PATCH/PUT /over_profiles/1.json
  def update
    respond_to do |format|
      if @over_profile.update(over_profile_params)
        format.html { redirect_to @over_profile, notice: 'Over profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @over_profile }
      else
        format.html { render :edit }
        format.json { render json: @over_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /over_profiles/1
  # DELETE /over_profiles/1.json
  def destroy
    @over_profile.destroy
    respond_to do |format|
      format.html { redirect_to over_profiles_url, notice: 'Over profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_over_profile
      @over_profile = OverProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def over_profile_params
      params.fetch(:over_profile, {})
    end
end
