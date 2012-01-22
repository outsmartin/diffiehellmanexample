# Diffie Hellman calculator

class Diffie
  attr_accessor :a, :g, :p, :alpha,:beta, :b,:k
end

def square_multi(p,g,secret)
  # g ** secret % p
  result = 1
  binary_array = secret.to_s(2).split("").map{|x| x.to_i}
  binary_array.each do |x|
    first = (g ** x)
    result = ( first * result ** 2) % p
  end
  result
end
