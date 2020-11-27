class ScaleBuilder
  NOTES = ['C','C#','D','E♭','E','F','F#','G','A♭','A','B♭','B']

  WHOLE = 2
  HALF = 1

  MAJOR_INTERVAL = [
    WHOLE,
    WHOLE,
    HALF,
    WHOLE,
    WHOLE,
    WHOLE,
    HALF
  ]

  MINOR_INTERVAL = [
    WHOLE,
    HALF,
    WHOLE,
    WHOLE,
    HALF,
    WHOLE,
    WHOLE
  ]

  def self.build(root, type)
    new(root, type).build
  end

  def initialize(root, type)
    @root = root
    @type = type
  end

  def build
    root_index = NOTES.find_index(@root)
    current_index = root_index
    scale = [NOTES[current_index]]

    interval = if @type == 'major'
                 MAJOR_INTERVAL
               elsif @type == 'minor'
                 MINOR_INTERVAL
               end

    interval.each do |interval|
      current_index = (current_index + interval) % NOTES.length
      scale << NOTES[current_index]
    end

    scale
  end
end
