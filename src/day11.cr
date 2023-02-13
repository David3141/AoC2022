class Day11
  getter monkeys : Array(Monkey)

  def initialize
    @monkeys = parse_input
    monkeys.each { |monkey| monkey.all_monkeys = monkeys }
  end

  def solve_1
    20.times { play_round }

    calc_monkey_business
  end

  def solve_2
    lcd = monkeys.map(&.test_divisible_by).product

    10_000.times { play_round(lcd: lcd) }

    calc_monkey_business
  end

  private def play_round(lcd = nil)
    monkeys.each(&.process_items(lcd: lcd))
  end

  private def calc_monkey_business
    monkeys.map(&.inspection_count).sort.last(2).product
  end

  class Monkey
    property items : Array(UInt64)
    getter operation : Proc(UInt64, UInt64)
    getter test_divisible_by : UInt32
    property target_index_true : UInt32
    property target_index_false : UInt32
    getter inspection_count : UInt64
    property all_monkeys : Array(Monkey)

    def initialize(@items, @operation, @test_divisible_by, @target_index_true, @target_index_false)
      @inspection_count = 0
      @all_monkeys = [] of Monkey
    end

    def process_items(lcd)
      @inspection_count += items.size

      items.each do |worry_level|
        worry_level = operation.call(worry_level)

        if lcd
          worry_level = worry_level % lcd
        else
          worry_level = worry_level // 3
        end

        target_index = worry_level % test_divisible_by == 0 ? target_index_true : target_index_false

        all_monkeys[target_index].receive_item(worry_level)
      end

      @items = [] of UInt64
    end

    def receive_item(item : UInt64)
      items.push(item)
    end
  end

  private def parse_input
    File.read("inputs/day11.txt").split("\n\n").map do |monkey_description|
      _, items_str, operation_str, test_str, true_str, false_str = monkey_description.lines.map(&.strip)

      items = items_str.lchop("Starting items: ").split(", ").map(&.to_u64)
      operation = parse_operation(operation_str)
      test_divisible_by = test_str.lchop("Test: divisible by ").to_u32
      target_index_true = true_str.lchop("If true: throw to monkey ").to_u32
      target_index_false = false_str.lchop("If false: throw to monkey ").to_u32

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

    return ->(old : UInt64) { old ** 2 } if str == "old * old"

    operand = str.split.last.to_u64

    return ->(old : UInt64) { old * operand } if str.includes? '*'

    ->(old : UInt64) { old + operand }
  end
end
