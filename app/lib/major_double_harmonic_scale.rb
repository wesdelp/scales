class MajorDoubleHarmonicScale < Scale
  def initialize(root)
    @root = root
  end

  private

  def mode
    'Major Double Harmonic'
  end

  def intervals
    [
      STEPS[:half],
      STEPS[:whole] + STEPS[:half],
      STEPS[:half],
      STEPS[:whole],
      STEPS[:half],
      STEPS[:whole] + STEPS[:half],
      # half step back to root
    ]
  end

  def scale_chords
    {
      'I' => CHORD_QUALITIES[:major],
      'II' => CHORD_QUALITIES[:major],
      'iii' => CHORD_QUALITIES[:minor],
      'iv' => CHORD_QUALITIES[:minor],
      'V' => CHORD_QUALITIES[:flat_five],
      'vi+' => CHORD_QUALITIES[:augmented],
      'vii' => CHORD_QUALITIES[:other]
    }
  end
end
