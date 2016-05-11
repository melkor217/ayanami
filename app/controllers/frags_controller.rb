class FragsController < ApplicationController
  before_action :set_frag, only: [:show]

  # GET /frags
  # GET /frags.json
  def index
    @frags = Frag.all
  end

  # GET /frags/1
  # GET /frags/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_frag
      @frag = Frag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def frag_params
      params.fetch(:frag, {})
    end
end
