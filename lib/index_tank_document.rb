module IndexTankDocument
  module ClassMethods
    class_eval do
      def index
        # TODO: Take url from config file
      	api  = IndexTank::Client.new(ENV['INDEXTANK_API_URL'] || 'http://:Q3b4SSnSPg+bNv@cf5f.api.indextank.com')
      	@@index ||= api.indexes('idx')
      	@@index
      end

      def search(query, fields=get_indexed_fields.join(","))
        index.search(query, :fetch => fields)
      end
      
      def indexes(*attributes)
        @@indexed_attributes = attributes
      end
      
      def get_indexed_fields
        @@indexed_attributes
      end
    end
  end
  
  module InstanceMethods
    def to_document
      data = {}
      self.get_indexed_fields.each do |attribute|
        val = self.method(attribute).call
        data[attribute.to_s] = val.to_s unless val.nil?
      end
      return data
    end

    def add_to_index
      index.document(id.to_s).add(to_document)
    end    
  end

  def self.included(receiver)
    @@indexed_attributes = []
    receiver.extend ClassMethods
    receiver.send :include, ClassMethods
    receiver.extend InstanceMethods
    receiver.send :include, InstanceMethods
  end
end
