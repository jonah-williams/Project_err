module Pbxproj
  class PbxProject  < Treetop::Runtime::SyntaxNode
    def description
      "Project"
    end
  end
  
  class PbxEndOfLineComment < Treetop::Runtime::SyntaxNode
    def description
      self.text_value
    end
  end
  
  class PbxComment < Treetop::Runtime::SyntaxNode
    def description
      self.text_value
    end
  end
  
  class PbxDictionary  < Treetop::Runtime::SyntaxNode
    def description
      "{}"
    end
  end
  
  class PbxArray  < Treetop::Runtime::SyntaxNode
    def description
      "()"
    end
  end
  
  class PbxAssignment  < Treetop::Runtime::SyntaxNode
    def description
      "="
    end
  end
  
  class PbxLiteral  < Treetop::Runtime::SyntaxNode
    def description
      self.text_value
    end
  end
  
  class PbxString  < Treetop::Runtime::SyntaxNode
    def description
      self.text_value
    end
  end
end