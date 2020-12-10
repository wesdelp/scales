class Scale
  NOTES = ['C','C#','D','E♭','E','F','F#','G','A♭','A','B♭','B']

  TYPES = [:major, :minor, :melodic_minor, :harmonic_minor]

  STEPS = {
    whole: 2,
    half: 1
  }

  SCALE_DEGREES = {
    triad: [0, 2, 4]
  }

  CHORD_QUALITIES = {
    major: '',
    minor: 'm',
    diminished: 'dim',
    augmented: 'aug'
  }

  def self.for(root)
    new(root).build
  end

  def initialize(root)
    raise 'Cannot initialize abstract Scale class'
  end

  def build
    @root_index = NOTES.find_index(@root)
    scale = build_scale
    pentatonic = pentatonic_steps.map { |i| scale[i] }
    chords = build_chords(scale)

    {
      name: "#{@root} #{mode}",
      root: @root_index,
      scale: scale,
      pentatonic: pentatonic,
      chords: chords
    }
  end

  private

  def mode
    raise NotImplementedError
  end

  def intervals
    raise NotImplementedError
  end

  def pentatonic_steps
    raise NotImplementedError
  end

  def scale_chords
    raise NotImplementedError
  end

  def build_scale
    current_index = @root_index
    scale = [current_index]

    intervals.each do |interval|
      current_index = (current_index + interval) % NOTES.length
      scale << current_index
    end

    scale
  end

  def build_chords(scale)
    chords = []

    scale_chords.each_with_index do |(quality, symbol), index|
      notes = []

      SCALE_DEGREES[:triad].each do |degree|
        notes << scale[(index + degree) % scale.length]
      end

      root_note = NOTES[scale[index]]

      chord = {
        notes: notes,
        root: scale[index],
        name: "#{root_note}#{symbol}",
        quality: quality
      }

      chords << chord
    end

    chords
  end
end
