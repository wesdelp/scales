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
    frequencies = build_frequencies(scale)
    pentatonic = pentatonic_steps.map { |i| scale[i] }
    chords = build_chords(scale)

    {
      name: "#{@root} #{mode}",
      root: @root_index,
      scale: scale,
      frequencies: frequencies,
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

  def build_frequencies(scale)
    base_note = NOTES.find_index('C')
    base_frequency = 262

    root_note = scale[0]
    frequencies = []

    scale.each do |note|
      # for listening purposes, ensure notes are always going UP
      # if we are below the root note, extend into the next octave
      note = note < root_note ? note + NOTES.length : note
      steps_from_base = base_note + note

      frequency = calculate_frequency(base_frequency, steps_from_base)
      frequencies << frequency
    end

    # for listening purposes, add the root note an octave up at the end
    frequencies << calculate_frequency(base_frequency, root_note + NOTES.length)
  end

  def calculate_frequency(base_frequency, steps_from_base)
    (base_frequency * 1.059463094359 ** steps_from_base).round(2)
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
