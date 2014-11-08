class Dispatch < ActiveRecord::Base

  def self.keywords_to_klasses
    
    keyword_to_klass_hash  = {}

    self.all.each do |dispatch|
      keyword_to_klass_hash[dispatch.keyword] = dispatch.klass 
    end
    
    keyword_to_klass_hash
  end

end

