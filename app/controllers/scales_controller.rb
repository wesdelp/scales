class ScalesController < ApplicationController
  def show
    @scale = ScaleBuilder.build('B', :major)
  end
end
