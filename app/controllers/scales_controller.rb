class ScalesController < ApplicationController
  def show
    @notes = Scale::NOTES
    @types = Scale::TYPES

    @root = params[:root] || @notes.first
    @type = params[:type] || @types.first

    @scale = ScaleBuilder.build(@root, @type)
  end

  def build
    redirect_to action: :show, root: params[:root], type: params[:type]
  end
end
