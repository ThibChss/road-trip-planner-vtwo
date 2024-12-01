class BalanceCalculator < BaseService
  Debt = Struct.new(:creditor, :debtor, :amount)
  attr_reader :expenses, :debts

  def initialize(expenses)
    @expenses = expenses
    @debts = []
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
    expenses.map.with_object(Hash.new(0)) do |expense, balances|
      balances[expense.paid_by.id] += expense.total_paid

      expense.paid_for.each do |participant|
        balances[participant.id] -= expense.total_paid / expense.paid_for.size
      end
    end
  end

  def calculate_debts
    loop do
      transform_balances
      break if balances.values.all? { |balance| balance >= 0 }

      debtor = balances.key(balances.values.min)
      creditor = balances.key(balances.values.max)

      debt_amount = [balances[debtor].abs, balances[creditor]].min
      next if debt_amount.zero?

      balances[debtor] += debt_amount
      balances[creditor] -= debt_amount

      debts << Debt.new(debtor.record, creditor.record, debt_amount)
    end
  end

  def transform_balances
    balances.transform_values! { |balance| balance.abs < 1e-10 ? 0 : balance.round(2) }
  end
end
