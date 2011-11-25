require "./lib/diffie.rb"
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
    #now brute force a and b
    @eve.a = 0
    until @eve.alpha == square_multi(@eve.p,@eve.g,@eve.a)  
      @eve.a += 1
    end
    puts @eve.a

    @eve.b = 0
    until @eve.beta == square_multi(@eve.p,@eve.g,@eve.b)  
      @eve.b += 1
    end
    puts @eve.b
  end
end

