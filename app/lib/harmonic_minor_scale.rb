class HarmonicMinorScale < Scale
  def initialize(root)
    @root = root
  end

  private

  def mode
    'Harmonic Minor'
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
      STEPS[:whole] + STEPS[:half],
      # half step back to root
    ]
  end

  def scale_chords
    {
      'i' => CHORD_QUALITIES[:minor],
      'ii°' => CHORD_QUALITIES[:diminished],
      'III+' => CHORD_QUALITIES[:augmented],
      'iv' => CHORD_QUALITIES[:minor],
      'V' => CHORD_QUALITIES[:major],
      'VI' => CHORD_QUALITIES[:major],
      'vii°' => CHORD_QUALITIES[:diminished]
    }
  end
end
