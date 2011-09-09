module Pbxproj
  class PbxNode < Treetop::Runtime::SyntaxNode
    def to_s
      self.class.name
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
  end
  
  class PbxProject < PbxNode
  end
  
  class PbxEndOfLineComment < PbxNode
  end
  
  class PbxComment < PbxNode
  end
  
  class PbxDictionary < PbxNode
  end
  
  class PbxArray < PbxNode
  end
  
  class PbxAssignment < PbxNode
  end
  
  class PbxValue < PbxNode
  end
  
  class PbxLiteral < PbxNode
  end
  
  class PbxString < PbxNode
  end
end