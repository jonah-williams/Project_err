module Pbxproj
  class PbxNode < Treetop::Runtime::SyntaxNode    
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
  end
  
  class PbxProject < PbxNode
  end
  
  class PbxEndOfLineComment < PbxNode
  end
  
  class PbxComment < PbxNode
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
        
    def [](key)
      self.pbx_elements.select{|e| e.class == PbxAssignment}.select{|a| a.variable.value.to_s == key}
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
  end
  
  class PbxAssignment < PbxNode
    def variable
      pbx_elements.first
    end
    
    def assigned_value
      pbx_elements.last
    end    
  end
  
  class PbxValue < PbxNode
    def value
      pbx_elements.select{|e| [PbxLiteral, PbxString].include? e.class}.first
    end
    
    def comment
      pbx_elements.select{|e| e.class == PbxComment}.first
    end
  end
  
  class PbxLiteral < PbxNode
  end
  
  class PbxString < PbxNode
  end
end