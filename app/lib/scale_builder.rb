class ScaleBuilder
  def self.build(root, type)
    case type
    when :major
      MajorScale.for(root)
    when :minor
      MinorScale.for(root)
    else
      raise 'Scale type not implemented'
    end
  end
end
