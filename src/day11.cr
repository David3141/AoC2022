class Day11
  getter monkeys : Array(Monkey)

  def initialize
    @monkeys = parse_input
    monkeys.each { |monkey| monkey.all_monkeys = monkeys }
  end

  def solve_1
    20.times { play_round }

    monkeys.map(&.inspection_count).sort.last(2).product
  end

  def solve_2
    0
  end

  private def play_round
    monkeys.each(&.process_items)
  end

  class Monkey
    property items : Array(Int32)
    getter operation : Proc(Int32, Int32)
    getter test_divisible_by : Int32
    property target_index_true : Int32
    property target_index_false : Int32
    getter inspection_count
    property all_monkeys : Array(Monkey)

    def initialize(@items, @operation, @test_divisible_by, @target_index_true, @target_index_false)
      @inspection_count = 0
      @all_monkeys = [] of Monkey
    end

    def process_items
      @inspection_count += items.size

      items.each do |worry_level|
        worry_level = operation.call(worry_level) // 3

        target_index = worry_level % test_divisible_by == 0 ? target_index_true : target_index_false

        all_monkeys[target_index].receive_item(worry_level)
      end

      @items = [] of Int32
    end

    def receive_item(item : Int32)
      items.push(item)
    end
  end

  private def parse_input
    File.read("inputs/day11.txt").split("\n\n").map do |monkey_description|
      _, items_str, operation_str, test_str, true_str, false_str = monkey_description.lines.map(&.strip)

      items = items_str.lchop("Starting items: ").split(", ").map(&.to_i)
      operation = parse_operation(operation_str)
      test_divisible_by = test_str.lchop("Test: divisible by ").to_i
      target_index_true = true_str.lchop("If true: throw to monkey ").to_i
      target_index_false = false_str.lchop("If false: throw to monkey ").to_i

      Monkey.new(
        items,
        operation,
        test_divisible_by,
        target_index_true: target_index_true,
        target_index_false: target_index_false
      )
    end
  end

  private def parse_operation(str : String)
    str = str.lchop("Operation: new = ")

    return ->(old : Int32) { old ** 2 } if str == "old * old"

    operand = str.split.last.to_i

    return ->(old : Int32) { old * operand } if str.includes? '*'

    ->(old : Int32) { old + operand }
  end
end
