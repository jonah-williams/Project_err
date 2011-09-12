module Pbxproj
  class PbxNode < Treetop::Runtime::SyntaxNode    
    def pbx_elements
      if !@pbx_elements
        @pbx_elements = []
        search_elements = Array.new(elements)
        while !search_elements.empty?
          e = search_elements.delete_at 0
          if e.class.name != "Treetop::Runtime::SyntaxNode"
            @pbx_elements << e
          else
            search_elements = e.elements + search_elements unless e.terminal?
          end
        end
      end
      @pbx_elements
    end
  end
  
  class PbxProject < PbxNode
    def root_dictionary
      pbx_elements.select{ |e| e.class == Pbxproj::PbxDictionary}.first
    end
    
    def comments
      pbx_elements.select{ |e| [Pbxproj::PbxComment, Pbxproj::PbxEndOfLineComment].include? e.class}
    end
  end
  
  class PbxEndOfLineComment < PbxNode
    def to_s
      text_value.gsub("\n", '')
    end
  end
  
  class PbxComment < PbxNode
    def to_s
      text_value
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
    
    def length
      contents.length
    end
    
    def keys
      contents.select{|e| e.class == PbxAssignment}.map{|a| a.variable.to_s}
    end
    
    def [](key)
      node = self.pbx_elements.select{|e| e.class == PbxAssignment}.select{|a| a.variable.value.to_s == key.to_s}.first
      node ? node.assigned_value : nil
    end
    
    def each(&block)
      keys.each do |key|
        yield key, self[key]
      end
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
    
    def length
      contents.length
    end
    
    def [](index)
      contents[index]
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
      pbx_elements.select{|e| [PbxLiteral, PbxString].include? e.class}.first.to_s
    end
    
    def to_s
      value
    end
    
    def comment
      pbx_elements.select{|e| e.class == PbxComment}.first
    end
  end
  
  class PbxLiteral < PbxNode
    def to_s
      text_value
    end
  end
  
  class PbxString < PbxNode
    def to_s
      text_value
    end
  end
end