require "./lib/diffie.rb"
require "benchmark"
describe "Diffie" do
  before(:all) do
    @alice = Diffie.new
    @alice.g = 20
    @alice.p = 137
    @alice.a = 5
    @alice.alpha = square_multi(@alice.p,@alice.g,@alice.a)
    @bob = Diffie.new
    @bob.g = 20
    @bob.p = 137
    @bob.b = 6
    @bob.beta = square_multi(@bob.p,@bob.g,@bob.b)
    # alpha and beta get exchanged
    @alice.beta = @bob.beta
    @bob.alpha = @alice.alpha
    puts @alice.alpha #91
  end
  it "should calc alpha" do
    @alice.alpha.should == (@alice.g ** @alice.a) % @alice.p
  end
  it "should calc beta" do
    @bob.beta.should == (@bob.g ** @bob.b) % @bob.p
  end
  it "both calc key and it should match" do
    #alice calcs k <=> beta^a(mod p)
    @alice.k = square_multi(@alice.p,@alice.beta,@alice.a)
    @bob.k = square_multi(@bob.p,@bob.alpha,@bob.b)
    #both got same key?
    @alice.k.should == @bob.k
    @alice.k.should == 109
  end

  #Solution for Praktikum 4 Aufgabe 5
  it "should solve praktikum" do
    @eve = Diffie.new
    @eve.p = 2281
    @eve.g = 1357
    @eve.alpha = 1468
    @eve.beta = 339
    #eve is set up with given values
    #n ow brute force a and b
    time = Benchmark.realtime do
      @eve.a = 0
      until @eve.alpha == square_multi(@eve.p,@eve.g,@eve.a)
        @eve.a += 1
      end
    end
    puts "Eve calculated #{@eve.a} for a. Time needed #{time * 1000} milliseconds"

    time = Benchmark.realtime do
      @eve.b = 0
      until @eve.beta == square_multi(@eve.p,@eve.g,@eve.b)
        @eve.b += 1
      end
    end
    puts @eve.b
    puts "Eve calculated #{@eve.b} for b. Time needed #{time * 1000} milliseconds"

  end
  it "should solve praktikum 4a2" do
    puts "start praktikum 4a2"
    g = 700
    p = 65267

    for g in 700..1050 do
      if (square_multi(p,g,2)==1)
        next
      end
      if ( square_multi(p,g,32633)==1)
        next
      else
        puts g
        break
      end
    end

  end
end

