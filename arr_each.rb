arr =[]
arr << 1
arr << 2
class Array
  def each(&block) 
    0.upto(self.length-1) do |i| 
      self[i]= self[i]*self[i]
      yield self[i]
    end
  end

end
arr.each { |i| p i }  