class GameService
  SYMBOLS = {
    'C' => 10, # Cherry
    'L' => 20, # Lemon
    'O' => 30, # Orange
    'W' => 40  # Watermelon
  }.freeze

  def initialize(session_credits)
    @session_credits = session_credits
  end

  def roll
    @session_credits -= 1
    slots = random_slots

    if winning_roll?(slots)
      credits_won = SYMBOLS[slots.first]
      @session_credits += credits_won if should_apply_winnings?
      {
        new_credits_count: @session_credits,
        slots: slots,
        winning_roll: true,
        credits_won: credits_won
      }
    else
      {
        new_credits_count: @session_credits,
        slots: slots,
        winning_roll: false,
        credits_won: 0
      }
    end
  end

  private

  def random_slots
    Array.new(3) { SYMBOLS.keys.sample }
  end

  def winning_roll?(slots)
    slots.uniq.length == 1
  end

  def should_apply_winnings?
    if @session_credits >= 40 && @session_credits <= 60
      rand < 0.7 # 30% chance of re-rolling
    elsif @session_credits > 60
      rand < 0.4 # 60% chance of re-rolling
    else
      true
    end
  end
end