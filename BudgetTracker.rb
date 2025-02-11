class PersonalBudget
  def initialize(income)
    @income = income # Monthly income
    @fixed_expenses = [] # List of fixed expenses
    @variable_expenses = [] # List of variable expenses
  end

  # Add a fixed expense (e.g. rent, utilities)
  def add_fixed_expense(name, amount)
    @fixed_expenses << { name: name, amount: amount }
  end

  # Add a variable expense (e.g. food, transport)
  def add_variable_expense(name, amounts)
    @variable_expenses << { name: name, amounts: amounts } # amounts is an array of past monthly expenses
  end

  # Calculate total of fixed expenses
  def calculate_fixed_expenses
    @fixed_expenses.sum { |expense| expense[:amount] }
  end

  # Calculate average of past variable expenses and predict next month's expense
  def calculate_forecasted_variable_expenses
    forecast = 0
    @variable_expenses.each do |expense|
      avg_expense = expense[:amounts].sum / expense[:amounts].size
      forecast += avg_expense
    end
    forecast
  end

  # Calculate total expenses (fixed + forecasted variable)
  def calculate_total_expenses
    calculate_fixed_expenses + calculate_forecasted_variable_expenses
  end

  # Calculate the potential savings after all expenses
  def calculate_savings
    savings = @income - calculate_total_expenses
    savings
  end

  # Suggest economy tips based on overspending categories
  def suggest_savings_tips
    tips = []
    @variable_expenses.each do |expense|
      avg_expense = expense[:amounts].sum / expense[:amounts].size
      current_month_expense = expense[:amounts].last
      if current_month_expense > avg_expense
        tips << "Consider reducing spending on #{expense[:name]} this month, you're above the average."
      end
    end
    tips
  end
end

# Example usage:

# Create a new budget manager
budget = PersonalBudget.new(5000) # Monthly income

# Add fixed expenses (e.g. rent, utilities)
budget.add_fixed_expense("Rent", 1500)
budget.add_fixed_expense("Electricity", 200)
budget.add_fixed_expense("Internet", 100)

# Add variable expenses (e.g. food, transport)
budget.add_variable_expense("Food", [300, 320, 290, 310]) # Past 4 months
budget.add_variable_expense("Transport", [150, 160, 140, 155]) # Past 4 months

# Calculate total expenses
puts "Total Expenses: #{budget.calculate_total_expenses}"

# Calculate savings
puts "Potential Savings: #{budget.calculate_savings}"

# Suggest savings tips
puts "Savings Tips: #{budget.suggest_savings_tips.join(', ')}"
