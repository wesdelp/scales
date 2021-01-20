class MajorLocrianScale < Scale
  def initialize(root)
    @root = root
  end

  private

  def mode
    'Major Locrian'
  end

  def intervals
    [
      STEPS[:half],
      STEPS[:whole],
      STEPS[:whole],
      STEPS[:half],
      STEPS[:whole],
      STEPS[:whole],
      # whole step back to root
    ]
  end

  def scale_chords
    {
      'I' => CHORD_QUALITIES[:major],
      'ii' => CHORD_QUALITIES[:minor],
      'iii' => CHORD_QUALITIES[:minor],
      'IV' => CHORD_QUALITIES[:major],
      'V' => CHORD_QUALITIES[:major],
      'vi' => CHORD_QUALITIES[:minor],
      'vii°' => CHORD_QUALITIES[:diminished]
    }
  end
end
