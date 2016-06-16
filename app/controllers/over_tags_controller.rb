class OverTagsController < ApplicationController
  before_action :set_over_tag, only: [:show, :edit, :update, :destroy]

  # GET /over_tags
  # GET /over_tags.json
  def index
    @over_tags = OverTag.all
  end

  # GET /over_tags/1
  # GET /over_tags/1.json
  def show
  end

  # GET /over_tags/new
  def new
    tag = params[:tag]
    @tag_data = OverTag.find_by_tag(tag)
    unless @tag_data
      @tag_data, @status = OverTag.set_data(tag)
    end
    render 'show'
  end

  # GET /over_tags/1/edit
  def edit
  end

  # POST /over_tags
  # POST /over_tags.json
  def create
    @over_tag = OverTag.new(over_tag_params)

    respond_to do |format|
      if @over_tag.save
        format.html { redirect_to @over_tag, notice: 'Over tag was successfully created.' }
        format.json { render :show, status: :created, location: @over_tag }
      else
        format.html { render :new }
        format.json { render json: @over_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /over_tags/1
  # PATCH/PUT /over_tags/1.json
  def update
    respond_to do |format|
      if @over_tag.update(over_tag_params)
        format.html { redirect_to @over_tag, notice: 'Over tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @over_tag }
      else
        format.html { render :edit }
        format.json { render json: @over_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /over_tags/1
  # DELETE /over_tags/1.json
  def destroy
    @over_tag.destroy
    respond_to do |format|
      format.html { redirect_to over_tags_url, notice: 'Over tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_over_tag
      @over_tag = OverTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def over_tag_params
      params.fetch(:over_tag, {})
    end
end
