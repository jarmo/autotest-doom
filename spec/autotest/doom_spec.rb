module Autotest
  describe "autotest-doom" do
    HOOKS = {:ran_command => []}

    before :each do
      reload
    end

    let(:autotest) {mock "autotest_results"}

    context "hook set-up" do
      it "sets to the first" do
        hooks.should have(2).procs
        hooks.last.should == @empty_proc
        hooks.first.should be_a(Proc)
      end

      it "returns false to continue executing autotest callbacks" do
        autotest.stub(:results).and_return("1 example, 0 failures")
        hooks.first[autotest].should be_false
      end

      it "sets titles for notification" do
        titles = TestNotifier::TITLES
        titles[:success].should == "Pass"
        titles[:fail].should == "FAIL"
      end

      it "sets success image for notification" do
        images = TestNotifier::IMAGES
        images[:success].should match(%r{/images/pass\.png})
        File.should exist(images[:success])
      end
    end

    context "running specs" do
      it "sets failure image when 1 failure" do
        autotest.stub(:results).and_return("1 example, 1 failure")
        hooks.first[autotest]
        TestNotifier::IMAGES[:fail].should match(%r{/images/fail10.png})
        File.should exist(TestNotifier::IMAGES[:fail])
      end

      it "sets failure image when 2-10 failures" do
        check_failure_image 2..10, "fail10.png"
      end

      it "sets specific image when 11-20 failures" do
        check_failure_image 11..20, "fail20.png"
      end

      it "sets specific failure image when 21-30 failures" do
        check_failure_image 21..30, "fail30.png"    
      end

      it "sets specific failure image when 31-40 failures" do
        check_failure_image 31..40, "fail40.png"
      end

      it "sets specific failure image when 41-50 failures" do
        check_failure_image 41..50, "fail50.png"
      end

      it "sets specific failure image when more than 50 failures" do
        check_failure_image 51..70, "fail50.png"
      end

      def check_failure_image(failures_range, expected_image)
        failures_range.each do |count|
          autotest.stub(:results).and_return("#{count} examples, #{count} failures")
          hooks.first[autotest]
          TestNotifier::IMAGES[:fail].should match(%r{/images/#{expected_image}})
            File.should exist(TestNotifier::IMAGES[:fail])
        end
      end
    end

    def reload
      hooks.clear << @empty_proc = proc {}
      load File.dirname(__FILE__) + "/../../lib/autotest/doom.rb"
    end

    def hooks
      HOOKS[:ran_command]
    end
  end
end
