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

  FREQUENCY = {
    base_note: NOTES.find_index('C'),
    base_frequency: 262
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
    frequencies = build_scale_frequencies(scale)
    pentatonic = pentatonic_steps.map { |i| scale[i] }
    chords = build_chords(scale)
    progressions = build_progressions(chords)

    {
      name: "#{@root} #{mode}",
      root: @root_index,
      scale: scale,
      frequencies: frequencies,
      pentatonic: pentatonic,
      chords: chords,
      progressions: progressions
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

  def build_scale_frequencies(scale)
    root_note = scale[0]
    frequencies = []

    scale.each do |note|
      # for listening purposes, ensure notes are always going UP
      # if we are below the root note, extend into the next octave
      note = note < root_note ? note + NOTES.length : note

      frequencies << calculate_frequency(note)
    end

    # for listening purposes, add the root note an octave up at the end
    frequencies << calculate_frequency(root_note + NOTES.length)
  end

  def build_chord_frequencies(chord)
    chord.map { |note| calculate_frequency(note) }
  end

  def calculate_frequency(note)
    steps_from_base = FREQUENCY[:base_note] + note
    (FREQUENCY[:base_frequency] * 1.059463094359 ** steps_from_base).round(2)
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
        quality: quality,
        frequencies: build_chord_frequencies(notes)
      }

      chords << chord
    end

    chords
  end

  def build_progressions(chords)
    progressions = []

    p = [[0, 4, 5, 3], [0, 3, 4], [0, 5, 3, 4], [5, 3, 0, 4], [0, 3, 5, 4]]

    p.each do |progression|
      progressions << progression.map { |i| chords[i] }
    end

    progressions
  end
end
