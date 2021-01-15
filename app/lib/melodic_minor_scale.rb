class MelodicMinorScale < Scale
  def initialize(root)
    @root = root
  end

  private

  def mode
    'Melodic Minor'
  end

  def intervals
    [
      STEPS[:whole],
      STEPS[:half],
      STEPS[:whole],
      STEPS[:whole],
      STEPS[:whole],
      STEPS[:whole],
      # half step back to root
    ]
  end

  def scale_chords
    {
      'i' => CHORD_QUALITIES[:minor],
      'ii' => CHORD_QUALITIES[:minor],
      'III+' => CHORD_QUALITIES[:augmented],
      'IV' => CHORD_QUALITIES[:major],
      'V' => CHORD_QUALITIES[:major],
      'vi°' => CHORD_QUALITIES[:diminished],
      'vii°' => CHORD_QUALITIES[:diminished]
    }
  end
end
