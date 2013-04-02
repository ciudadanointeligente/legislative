require 'delegate'

module Representable
  # The Binding wraps the Definition instance for this property and provides methods to read/write fragments.
  class Binding < SimpleDelegator
    class FragmentNotFound
    end

    def self.build(definition, *args)
      # DISCUSS: move #create_binding to this class?
      return definition.create_binding(*args) if definition.binding
      build_for(definition, *args)
    end

    def definition  # TODO: remove in 1.4.
      raise "Binding#definition is no longer supported as all Definition methods are now delegated automatically."
    end

    def initialize(definition, represented, user_options={})  # TODO: remove default arg.
      super(definition)
      @represented  = represented
      @user_options = user_options
    end

    attr_reader :user_options, :represented # TODO: make private/remove.

    # Main entry point for rendering/parsing a property object.
    def serialize(value)
      value
    end

    def deserialize(fragment)
      fragment
    end

    # Retrieve value and write fragment to the doc.
    def compile_fragment(doc)
      return represented_exec_for(:writer, doc) if options[:writer]

      write_fragment(doc, get)
    end

    # Parse value from doc and update the model property.
    def uncompile_fragment(doc)
      return represented_exec_for(:reader, doc) if options[:reader]

      read_fragment(doc) do |value|
        set(value)
      end
    end

    def write_fragment(doc, value)
      value = default_for(value)

      write_fragment_for(value, doc)
    end

    def write_fragment_for(value, doc)
      return if skipable_nil_value?(value)
      write(doc, value)
    end

    def read_fragment(doc)
      value = read_fragment_for(doc)

      if value == FragmentNotFound
        return unless has_default?
        value = default
      end

      yield value
    end

    def read_fragment_for(doc)
      read(doc)
    end

    def get
      return represented_exec_for(:getter) if options[:getter]
      represented.send(getter)
    end

    def set(value)
      value = represented_exec_for(:setter, value) if options[:setter]
      represented.send(setter, value)
    end

  private
    # Execute the block for +option_name+ on the represented object.
    def represented_exec_for(option_name, *args)
      return unless options[option_name]
      represented.instance_exec(*args+[user_options], &options[option_name])
    end


    # Hooks into #serialize and #deserialize to extend typed properties
    # at runtime.
    module Extend
      # Extends the object with its representer before serialization.
      def serialize(*)
        extend_for(super)
      end

      def deserialize(*)
        extend_for(super)
      end

      def extend_for(object)
        if mod = representer_module_for(object) # :extend.
          object.extend(*mod)
        end

        object
      end

    private
      def representer_module_for(object, *args)
        call_proc_for(representer_module, object)   # TODO: how to pass additional data to the computing block?`
      end

      def call_proc_for(proc, *args)
        return proc unless proc.is_a?(Proc)
        # DISCUSS: use represented_exec_for here?
        @represented.instance_exec(*args, &proc)
      end
    end

    module Object
      include Binding::Extend  # provides #serialize/#deserialize with extend.

      def serialize(object)
        return object if object.nil?

        super.send(serialize_method, @user_options.merge!({:wrap => false}))  # TODO: pass :binding => self
      end

      def deserialize(data)
        # DISCUSS: does it make sense to skip deserialization of nil-values here?
        super(create_object(data)).send(deserialize_method, data, @user_options)
      end

      def create_object(fragment)
        instance_for(fragment) or class_for(fragment)
      end

    private
      def class_for(fragment, *args)
        item_class = class_from(fragment) or return fragment # DISCUSS: is it legal to return the very fragment here?
        item_class.new
      end

      def class_from(fragment, *args)
        call_proc_for(sought_type, fragment)
      end

      def instance_for(fragment, *args)
        return unless options[:instance]
        call_proc_for(options[:instance], fragment)
      end
    end
  end
end
