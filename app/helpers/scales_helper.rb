module ScalesHelper
  def types_for_select(types)
    select = {}
    types.each do |t|
      select[t.to_s.titleize] = t
    end

    select
  end

  def key_class(key, scale_notes, scale_root)
    if key == scale_root
      'active-root'
    elsif scale_notes.include?(key)
      'active'
    else
      ''
    end
  end
end
