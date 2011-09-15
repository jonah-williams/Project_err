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
    
    def content_match?(other)
      self == other
    end
    
    def ==(other)
      (other.is_a? PbxNode) && (self.text_value == other.text_value)
    end
    
    def eql?(other)
      (self.class == other.class) && (self == other)
    end
  end
  
  class PbxProject < PbxNode
    def root_dictionary
      pbx_elements.select{ |e| e.class == Pbxproj::PbxDictionary}.first
    end
    
    def comments
      pbx_elements.select{ |e| [Pbxproj::PbxComment, Pbxproj::PbxEndOfLineComment].include? e.class}
    end
    
    def build_files
      objects_of_type "PBXBuildFile"
    end
    
    def container_item_proxies
      objects_of_type "PBXContainerItemProxy"
    end
    
    def file_references
      objects_of_type "PBXFileReference"
    end
    
    def framework_build_phases
      objects_of_type "PBXFrameworksBuildPhase"
    end
    
    def resources_build_phases
      objects_of_type "PBXResourcesBuildPhase"
    end
    
    def groups
      objects_of_type "PBXGroup"
    end
    
    def targets
      objects_of_type("PBXNativeTarget").map {|target| PbxTarget.new(target, self)}
    end
    
    def project_settings
      objects_of_type "PBXProject"
    end
    
    def shell_script_build_phases
      objects_of_type "PBXShellScriptBuildPhase"
    end
    
    def sources_build_phases
      objects_of_type "PBXSourcesBuildPhase"
    end
    
    def target_dependencies
      objects_of_type "PBXTargetDependency"
    end
    
    def variant_groups
      objects_of_type "PBXVariantGroup"
    end
    
    def build_configurations
      objects_of_type "XCBuildConfiguration"
    end
    
    def configuration_lists
      objects_of_type "XCConfigurationList"
    end
    
    private
    
    def objects_of_type(type)
      objects = []
      root_dictionary['objects'].each do |key, value|
        if (value.class == Pbxproj::PbxDictionary) && (value['isa'].to_s == type.to_s)
          objects << value
        end
      end
      objects
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
  
  class PbxTarget
    attr_accessor :target
    attr_accessor :project
    def initialize(target, project)
      @target = target
      @project = project
    end
    
    def summary
      summary = target[:name].value << "\n"
      summary << "\t"*2 << "Builds a #{target[:productType]}\n"
      summary << "\n"
      
      summary << "\t"*2 << "Build phases:\n"
      target[:buildPhases].each do |build_phase_id|
        build_phase = @project.root_dictionary[:objects][build_phase_id.value]
        summary << "\t"*3 << "#{build_phase[:isa].value}\n"
        build_phase[:files].each do |file_id|
          file_ref_id = @project.root_dictionary[:objects][file_id.value][:fileRef]
          file = @project.root_dictionary[:objects][file_ref_id.value]
          file_path = file[:path]
          summary << "\t"*4
          if file_path
            summary << file_path.value
          else
            summary << file[:name].value
          end
          summary << "\n"
        end
      end
      
      summary << "\t"*2 << "Build rules:\n"
      target[:buildRules].each do |build_rule_id|
        summary << "\t"*3 << build_rule_id.value
      end
      
      summary << "\t"*2 << "Dependencies:\n"
      target[:dependencies].each do |dependency_id|
        target_dependency_id = @project.root_dictionary[:objects][dependency_id][:target]
        dependant_target_id = @project.root_dictionary[:objects][target_dependency_id]
        summary << "\t"*3 << dependant_target_id[:name].value << "\n"
      end
      
      summary
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
    
    def each(&block)
      contents.each do |element|
        yield element
      end
    end
  end
  
  class PbxAssignment < PbxNode
    def variable
      pbx_elements.first
    end
    
    def assigned_value
      pbx_elements.last
    end
    
    def content_match?(other)
      (self == other) ||
      (other.instance_of(self.class) && 
        ((self.variable.value == other.variable.value) || 
        (self.variable.comment == other.variable.comment))
      )
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