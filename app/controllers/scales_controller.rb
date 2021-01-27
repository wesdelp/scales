class ScalesController < ApplicationController
  def show
    @notes = Scale::NOTES
    @types = Scale::TYPES

    @root = root || @notes.first
    @type = type || @types.first

    @scale = ScaleBuilder.build(@root, @type)
  end

  def build
    redirect_to action: :show, root: root, type: type
  end

  def generate_midi
    send_data(
      MidiBuilder.build_progression(root, type, params[:progression].to_i),
      filename: "#{root}#{type}_chord_progression.mid",
      type: 'audio/midi',
      disposition: 'attachment'
    )
  end

  private

  def root
    params[:root]
  end

  def type
    params[:type]
  end
end
