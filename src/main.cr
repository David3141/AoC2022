require "benchmark"
require "option_parser"
require "./day01.cr"
require "./day02.cr"
require "./day03.cr"
require "./day04.cr"
require "./day05.cr"
require "./day06.cr"
require "./day07.cr"
require "./day08.cr"
require "./day09.cr"
require "./day10.cr"
require "./day11.cr"

DAYS = {
  1 => Day01,
  2 => Day02,
  3 => Day03,
  4 => Day04,
  5 => Day05,
  6 => Day06,
  7 => Day07,
  8 => Day08,
  9 => Day09,
  10 => Day10,
  11 => Day11,
}

run_as_benchmark = false
days_to_run = [DAYS.values.last] # Run last day as default
specify_days = false

OptionParser.parse do |parser|
  parser.on "-a", "--all", "Run all days" do
    puts "Running all days..."
    days_to_run = DAYS.values
  end

  parser.on "-d DAYS", "--days=DAYS" do |days|
    days_to_run = days.split(',').map(&.to_i).map { |i| DAYS[i] }
  end

  parser.on "-bm", "--benchmark", "Run as benchmark" do
    run_as_benchmark = true
  end
end

if run_as_benchmark
  Benchmark.bm do |x|
    days_to_run.map do |day_class|
      x.report "#{day_class.name} part 1" do
        day_class.new.solve_1
      end

      x.report "#{day_class.name} part 2" do
        day_class.new.solve_2
      end
    end
  end
else
  days_to_run.map do |day_class|
    puts "#{day_class.name} part 1: #{day_class.new.solve_1}"
    puts "#{day_class.name} part 2: #{day_class.new.solve_2}"
  end
end
