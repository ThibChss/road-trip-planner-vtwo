class BalanceCalculator < BaseService
  class IterationError < StandardError; end

  TOLERANCE = 1e-5
  MAX_ITERATIONS = 1000
  private_constant :TOLERANCE, :MAX_ITERATIONS

  Debt = Struct.new(:creditor_id, :debtor_id, :amount)

  private attr_reader :expenses, :debts

  def initialize(expenses)
    @expenses = expenses
    @debts = []
    @iterations = 0
  end

  def call
    calculate_debts
    debts
  end

  private

  def balances
    @balances ||= calculate_balances
  end

  def calculate_balances
    expenses.map.with_object(Hash.new(0)) do |expense, balance|
      # Add the full amount to what the payer paid
      balance[expense.paid_by.id] += expense.total_paid

      # Subtract what each person owes
      expense.paid_for.each do |participant|
        balance[participant.id] -= (expense.total_paid.to_f / expense.paid_for.size)
      end
    end
  end

  def calculate_debts
    while balances.values.any? { it.abs >= TOLERANCE }
      break if debtors.empty? || creditors.empty?

      settle_next_debt
      monitor_iteration
    end
  end

  def settle_next_debt
    debtor_id, debt = debtors.min_by { |_, value| -value }
    creditor_id, credit = creditors.max_by { |_, value| value }

    amount = [debt.abs, credit].min

    balances[debtor_id] += amount
    balances[creditor_id] -= amount

    debts.push(Debt.new(creditor_id, debtor_id, amount.round))
  end

  def debtors
    balances.select { |_, value| value < -TOLERANCE }
  end

  def creditors
    balances.select { |_, value| value > TOLERANCE }
  end

  def monitor_iteration
    return unless (@iterations += 1) > MAX_ITERATIONS

    raise IterationError, "Maximum iterations exceeded"
  end
end
