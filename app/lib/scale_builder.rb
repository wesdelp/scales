class ScaleBuilder
  NOTES = ['C','C#','D','E♭','E','F','F#','G','A♭','A','B♭','B']

  SCALE_DEGREES = {
    triad: [0, 2, 4]
  }

  PENTATONIC_NOTES = [0, 1, 2, 4, 5]

  WHOLE_STEP = 2
  HALF_STEP = 1

  MAJOR_INTERVAL = [
    WHOLE_STEP,
    WHOLE_STEP,
    HALF_STEP,
    WHOLE_STEP,
    WHOLE_STEP,
    WHOLE_STEP,
    #HALF_STEP
  ]

  MINOR_INTERVAL = [
    WHOLE_STEP,
    HALF_STEP,
    WHOLE_STEP,
    WHOLE_STEP,
    HALF_STEP,
    WHOLE_STEP,
    #WHOLE_STEP
  ]

  CHORD_QUALITIES = {
    major: '',
    minor: 'm',
    diminished: 'dim',
    augmented: 'aug'
  }

  MAJOR_CHORD_QUALITIES = {
    'I' => CHORD_QUALITIES[:major],
    'ii' => CHORD_QUALITIES[:minor],
    'iii' => CHORD_QUALITIES[:minor],
    'IV' => CHORD_QUALITIES[:major],
    'V' => CHORD_QUALITIES[:major],
    'vi' => CHORD_QUALITIES[:minor],
    'viio' => CHORD_QUALITIES[:diminished]
  }

  MINOR_CHORD_QUALITIES = {
    'i' => CHORD_QUALITIES[:minor],
    'iio' => CHORD_QUALITIES[:diminished],
    'III' => CHORD_QUALITIES[:major],
    'iv' => CHORD_QUALITIES[:minor],
    'v' => CHORD_QUALITIES[:minor],
    'VI' => CHORD_QUALITIES[:major],
    'VII' => CHORD_QUALITIES[:major]
  }

  def self.build(root, type)
    new(root, type).build
  end

  def initialize(root, type)
    @root = root
    @type = type
  end

  def build
    scale = build_scale
    pentatonic = PENTATONIC_NOTES.map { |i| scale[i] }
    chords = build_chords(scale)

    {
      name: "#{@root} #{@type}",
      scale: scale,
      pentatonic: pentatonic,
      chords: chords
    }
  end

  private

  def build_scale
    root_index = NOTES.find_index(@root)
    current_index = root_index
    scale = [current_index]

    interval = if @type == 'major'
                 MAJOR_INTERVAL
               elsif @type == 'minor'
                 MINOR_INTERVAL
               end

    interval.each do |interval|
      current_index = (current_index + interval) % NOTES.length
      scale << current_index
    end

    scale
  end

  def build_chords(scale)
    qualities = if @type == 'major'
                  MAJOR_CHORD_QUALITIES
                elsif @type == 'minor'
                  MINOR_CHORD_QUALITIES
                end

    chords = []

    qualities.each_with_index do |(quality, symbol), index|
      notes = []

      SCALE_DEGREES[:triad].each do |degree|
        notes << scale[(index + degree) % scale.length]
      end

      root_note = NOTES[scale[index]]

      chord = {
        notes: notes,
        name: "#{root_note}#{symbol}",
        quality: quality
      }

      chords << chord
    end

    chords
  end
end
