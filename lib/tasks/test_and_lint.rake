desc "Run tests and rubocop"
task test_and_lint: :environment do
  puts "\n=== Running Tests ==="
  raise "Tests failed!" unless system("bin/rails test")

  puts "\n=== Running Rubocop ==="
  raise "Rubocop failed!" unless system("bundle exec rubocop")

  puts "\n=== All checks passed! ==="
end
