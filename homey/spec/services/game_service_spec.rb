require 'rails_helper'

RSpec.describe GameService, type: :service do
  describe '#roll' do
    context 'when session credits are below 40' do
      it 'returns winning_roll with true probability' do
        winning_count = 0
        game_service = GameService.new(10)

        srand(12345) # Set the random seed
        1000.times do
          result = game_service.roll
          winning_count += 1 if result[:winning_roll]
        end

        expect(winning_count).to eq(59) # Expected winning count with the fixed seed
      end
    end

    context 'when session credits are between 40 and 60' do
      it 'rerolls 30% of the time when winning' do
        winning_count = 0
        game_service = GameService.new(50)

        srand(12345) # Set the random seed
        1000.times do
          result = game_service.roll
          winning_count += 1 if result[:winning_roll]
        end

        expect(winning_count).to eq(62) # Expected winning count with the fixed seed
      end
    end

    context 'when session credits are above 60' do
      it 'rerolls 60% of the time when winning' do
        winning_count = 0
        game_service = GameService.new(70)

        srand(12345) # Set the random seed
        1000.times do
          result = game_service.roll
          winning_count += 1 if result[:winning_roll]
        end

        expect(winning_count).to eq(54) # Expected winning count with the fixed seed
      end
    end
  end
end
