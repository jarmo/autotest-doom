TestNotifier::TITLES.merge! :fail => "FAIL",
                            :success => "Pass"

TestNotifier::IMAGES[:success] = File.dirname(__FILE__) + "/../../images/doom/pass.png"

doom_hook = proc do |at|
  content = at.results.to_s
  rspec_matches = content.match(/(\d+) failures?/)
  failures = rspec_matches[0].to_i
  if failures > 0
    count = [(9 + failures) / 10 * 10, 50].min
    TestNotifier::IMAGES[:fail] = File.dirname(__FILE__) + "/../../images/doom/fail#{count}.png"
  end
  false
end

Autotest::HOOKS[:ran_command].unshift doom_hook

