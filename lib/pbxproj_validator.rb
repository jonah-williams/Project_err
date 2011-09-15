require File.expand_path(File.join(File.dirname(__FILE__), 'pbxproj_nodes.rb'))

module Pbxproj
  class PbxNode
    def summary
      to_s
    end
  end
  
  class PbxProject
    def summary(target = nil)
      summary = ""

      summary << "Project\n"
      summary << "\n"
      summary << "Build Targets:\n"
      self.targets.each do |target|
        summary << "\t" << target.summary << "\n"
      end
      
      summary
    end
    
    def validate(target = nil)
    end
  end
  
  class PbxDictionary
    def summary
      summary = "{ "
      each do |key, value|
        summary << key << " = " << value.summary << ";\t"
      end
      summary << " }"
      summary
    end
  end
  
  class PbxAssignment
    def summary
      variable.value + " = " + assigned_value.value
    end
  end
end