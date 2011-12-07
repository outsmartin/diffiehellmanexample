require "./diffie.rb"
#require "benchmark"
a = 0
p = 2281
g = 1357
alpha = 1468
beta = 339
#time = Benchmark.realtime do
  until alpha == square_multi(p,g,a)
    a += 1
  end
#end
#puts "Eve calculated #{a} in #{time*1000} milliseconds"
