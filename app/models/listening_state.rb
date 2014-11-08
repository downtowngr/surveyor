class ListeningState < ActiveRecord::Base
  def self.trigger

    eval "#{self.klass}.run(#{self.event})"
 
  end
end

