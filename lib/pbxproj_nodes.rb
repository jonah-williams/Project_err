module Pbxproj
  class PbxNode < Treetop::Runtime::SyntaxNode
    def to_s
      to_indented_s
    end
    
    def pbx_elements
      pbx_elements = []
      search_elements = Array.new(elements)
      while !search_elements.empty?
        e = search_elements.delete_at 0
        if e.class.name != "Treetop::Runtime::SyntaxNode"
          pbx_elements << e
        else
          search_elements = e.elements + search_elements unless e.terminal?
        end
      end
      pbx_elements
    end
    
    def to_indented_s(indentation_level = 0)
      self.class.name
    end
    
    def indent(indentation_level = 0)
      ' ' * indentation_level
    end
  end
  
  class PbxProject < PbxNode
    def to_indented_s(indentation_level = 0)
      'Project' << "\n" << pbx_elements.map{|e| e.to_indented_s(indentation_level)}.join("\n")
    end
  end
  
  class PbxEndOfLineComment < PbxNode
    def to_indented_s(indentation_level = 0)
      indent(indentation_level) + text_value
    end
  end
  
  class PbxComment < PbxNode
    def to_indented_s(indentation_level = 0)
      indent(indentation_level) + text_value
    end
  end
  
  class PbxDictionary < PbxNode
    def contents
      contents = pbx_elements
      contents.delete(comment)
      contents
    end
    
    def comment
      c = pbx_elements.last
      c.class == PbxComment ? c : nil
    end
    
    def to_indented_s(indentation_level = 0)
      indent(indentation_level) + ("{\n" + contents.map{|c| c.to_indented_s(indentation_level + 1)}.join(";\n") + "\n" + indent(indentation_level) + "}" + ' ' + comment.to_s).strip
    end
  end
  
  class PbxArray < PbxNode
    def contents
      contents = pbx_elements
      contents.delete(comment)
      contents
    end
    
    def comment
      c = pbx_elements.last
      c.class == PbxComment ? c : nil
    end
    
    def to_indented_s(indentation_level = 0)
      indent(indentation_level) + ('(' + contents.map(&:to_s).join(', ') + ')' + ' ' + comment.to_s).strip
    end
  end
  
  class PbxAssignment < PbxNode
    def variable
      pbx_elements.first
    end
    
    def assigned_value
      pbx_elements.last
    end
    
    def to_indented_s(indentation_level = 0)
      variable.to_indented_s(indentation_level) + ' = ' + assigned_value.to_indented_s(indentation_level)
    end
  end
  
  class PbxValue < PbxNode
    def value
      pbx_elements.select{|e| [PbxLiteral, PbxString].include? e.class}.first
    end
    
    def comment
      pbx_elements.select{|e| e.class == PbxComment}.first
    end
    
    def to_indented_s(indentation_level = 0)
      indent(indentation_level) + (value.to_s + ' ' + comment.to_s).strip
    end
  end
  
  class PbxLiteral < PbxNode
    def to_indented_s(indentation_level = 0)
      indent(indentation_level) + text_value
    end
  end
  
  class PbxString < PbxNode
    def to_indented_s(indentation_level = 0)
      indent(indentation_level) + text_value
    end
  end
end