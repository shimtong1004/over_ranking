#encoding: utf-8
require 'open-uri'

class OverHerosController < ApplicationController
  before_action :set_over_hero, only: [:show, :edit, :update, :destroy]

  # GET /over_heros
  # GET /over_heros.json
  def index
    @over_heros = OverHero.all
  end

  # GET /over_heros/1
  # GET /over_heros/1.json
  def show
  end

  # GET /over_heros/new
  def new
    @over_hero = OverHero.new
  end

  # GET /over_heros/1/edit
  def edit
  end

  # POST /over_heros
  # POST /over_heros.json
  def create
    @over_hero = OverHero.new(over_hero_params)

    respond_to do |format|
      if @over_hero.save
        format.html { redirect_to @over_hero, notice: 'Over hero was successfully created.' }
        format.json { render :show, status: :created, location: @over_hero }
      else
        format.html { render :new }
        format.json { render json: @over_hero.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /over_heros/1
  # PATCH/PUT /over_heros/1.json
  def update
    respond_to do |format|
      if @over_hero.update(over_hero_params)
        format.html { redirect_to @over_hero, notice: 'Over hero was successfully updated.' }
        format.json { render :show, status: :ok, location: @over_hero }
      else
        format.html { render :edit }
        format.json { render json: @over_hero.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /over_heros/1
  # DELETE /over_heros/1.json
  def destroy
    @over_hero.destroy
    respond_to do |format|
      format.html { redirect_to over_heros_url, notice: 'Over hero was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_over_hero
      @over_hero = OverHero.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def over_hero_params
      params.fetch(:over_hero, {})
    end
end
