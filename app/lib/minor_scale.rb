class MinorScale < Scale
  def initialize(root)
    @root = root
  end

  private

  def mode
    'Minor'
  end

  def pentatonic_steps
    [0, 2, 3, 4, 6]
  end

  def intervals
    [
      STEPS[:whole],
      STEPS[:half],
      STEPS[:whole],
      STEPS[:whole],
      STEPS[:half],
      STEPS[:whole],
      #STEPS[:whole]
    ]
  end

  def scale_chords
    {
      'i' => CHORD_QUALITIES[:minor],
      'ii°' => CHORD_QUALITIES[:diminished],
      'III' => CHORD_QUALITIES[:major],
      'iv' => CHORD_QUALITIES[:minor],
      'v' => CHORD_QUALITIES[:minor],
      'VI' => CHORD_QUALITIES[:major],
      'VII' => CHORD_QUALITIES[:major]
    }
  end
end
