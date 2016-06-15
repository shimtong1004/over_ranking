#encoding: utf-8
require 'open-uri'
class OverAchievementsController < ApplicationController
  before_action :set_over_achievement, only: [:show, :edit, :update, :destroy]

  # GET /over_achievements
  # GET /over_achievements.json
  def index
    # @over_achievements = OverAchievement.all
  end
  

  # GET /over_achievements/1
  # GET /over_achievements/1.json
  def show
    
  end

  # GET /over_achievements/new
  def new
    @over_achievement = OverAchievement.new
  end

  # GET /over_achievements/1/edit
  def edit
  end

  # POST /over_achievements
  # POST /over_achievements.json
  def create
    @over_achievement = OverAchievement.new(over_achievement_params)

    respond_to do |format|
      if @over_achievement.save
        format.html { redirect_to @over_achievement, notice: 'Over achievement was successfully created.' }
        format.json { render :show, status: :created, location: @over_achievement }
      else
        format.html { render :new }
        format.json { render json: @over_achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /over_achievements/1
  # PATCH/PUT /over_achievements/1.json
  def update
    respond_to do |format|
      if @over_achievement.update(over_achievement_params)
        format.html { redirect_to @over_achievement, notice: 'Over achievement was successfully updated.' }
        format.json { render :show, status: :ok, location: @over_achievement }
      else
        format.html { render :edit }
        format.json { render json: @over_achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /over_achievements/1
  # DELETE /over_achievements/1.json
  def destroy
    @over_achievement.destroy
    respond_to do |format|
      format.html { redirect_to over_achievements_url, notice: 'Over achievement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_over_achievement
      @over_achievement = OverAchievement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def over_achievement_params
      params.fetch(:over_achievement, {})
    end
end
