class ScalesController < ApplicationController
  def show
    @scale = ScaleBuilder.build('B', 'minor')
  end
end
