class MajorScale < Scale
  def initialize(root)
    @root = root
  end

  private

  def mode
    'Major'
  end

  def pentatonic_steps
    [0, 1, 2, 4, 5]
  end

  def intervals
    [
      STEPS[:whole],
      STEPS[:whole],
      STEPS[:half],
      STEPS[:whole],
      STEPS[:whole],
      STEPS[:whole],
      # half step back to root
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

  def common_progressions
    [
      [ 0, 4, 5, 3 ],
      [ 0, 3, 4 ],
      [ 0, 5, 3, 4 ],
      [ 5, 3, 0, 4 ],
      [ 0, 5, 1, 4 ],
      [ 0, 2, 3, 4 ],
      [ 0, 3, 0, 4 ],
      [ 0, 3, 1, 4 ],
    ]
  end
end
