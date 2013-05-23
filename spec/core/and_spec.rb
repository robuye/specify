require 'spec_helper'

describe Specify::Core do
  let(:dividable_by_class) do
    Class.new do
      def initialize(divisor); @divisor = divisor; end
      def is_satisfied_by?(subject); subject % @divisor == 0; end
    end
  end

  let(:div_by_3) { dividable_by_class.new(3) }
  let(:div_by_4) { dividable_by_class.new(4) }

  describe Specify::Core::And do
    it "combine multiple specs correct" do
      and_spec = Specify::Core::And.new(div_by_3, div_by_4)
  
      and_spec.is_satisfied_by?(12).should be_true
      and_spec.is_satisfied_by?(8).should be_false
    end
  end

  describe Specify::Core::Or do
    it "combine multiple specs correct" do
      and_spec = Specify::Core::Or.new(div_by_3, div_by_4)
  
      and_spec.is_satisfied_by?(7).should be_false
      and_spec.is_satisfied_by?(8).should be_true
      and_spec.is_satisfied_by?(9).should be_true
    end
  end

  describe Specify::Core::Common do
    let(:my_spec_class) do
      Class.new(dividable_by_class) do
        include Specify::Core::Common
      end
    end

    let(:div_by_3) { my_spec_class.new(3) }
    let(:div_by_4) { my_spec_class.new(4) }
    let(:div_by_5) { my_spec_class.new(5) }

    it "included exposes #and method" do
      div_by_3.and(div_by_4).is_satisfied_by?(12).should be_true
    end

    it "included exposes #or method" do
      div_by_3.or(div_by_4).is_satisfied_by?(4).should be_true
    end

    it "allows chaining and/or specs" do
      div_by_3.and(div_by_4).or(div_by_4).is_satisfied_by?(3).should be_false
      div_by_3.and(div_by_4).or(div_by_4).is_satisfied_by?(8).should be_true
    end

    it "allows nesting in chaining" do
      div_by_3.or(div_by_4.and(div_by_5)).is_satisfied_by?(20).should be_true
      div_by_3.or(div_by_4.and(div_by_5)).is_satisfied_by?(32).should be_false
    end

    it "allows chaining composite specs" do
      div_by_4_and_5 = div_by_4.and(div_by_5)
      div_by_3.or(div_by_4_and_5).is_satisfied_by?(20).should be_true
    end

    it "#or and #and return specification object" do
      div_by_3.or(div_by_4).should be_kind_of(Specify::Core::Common)
      div_by_3.and(div_by_4).should be_kind_of(Specify::Core::Common)
    end
  end
end
