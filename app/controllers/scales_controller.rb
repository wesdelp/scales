class ScalesController < ApplicationController
  def show
    @chords = [
      {
        name: 'Em',
        notes: [1,4,6]
      },
      {
        name: 'Am',
        notes: [3,5,7]
      },
      {
        name: 'Am',
        notes: [3,5,7]
      }
    ]
  end
end
