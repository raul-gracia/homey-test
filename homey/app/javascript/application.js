// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import 'controllers'

const rollButton = document.getElementById('roll')
const slot1 = document.getElementById('slot1')
const slot2 = document.getElementById('slot2')
const slot3 = document.getElementById('slot3')
const creditsElement = document.getElementById('credits')
const winningMessage = document.getElementById('winning-message')
const winningMessageText = document.getElementById('winning-message-text')
let credits = parseInt(creditsElement.textContent, 10)

function updateCredits(newCredits) {
  credits = newCredits
  creditsElement.textContent = credits
}

function showWinningMessage(winningMessage) {
  winningMessage.style.display === 'block'
  winningMessageText.textContent = `You won ${result.credits_won} credits!`
}
function hideWinningMessage() {
  winningMessage.style.display === 'none'
}

function updateSlot(slotElement, symbol, delay) {
  setTimeout(() => {
    slotElement.textContent = symbol
  }, delay * 1000)
}

rollButton.addEventListener('click', async () => {
  hideWinningMessage()
  if (credits <= 0) {
    alert('You have no credits left!')
    return
  }

  // Show spinning state
  slot1.textContent = 'X'
  slot2.textContent = 'X'
  slot3.textContent = 'X'

  try {
    const response = await fetch('/api/roll', {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    })

    if (!response.ok) {
      throw new Error('Failed to fetch roll results')
    }

    const result = await response.json()
    updateCredits(result.new_credits_count)
    updateSlot(slot1, result.slots[0], 1)
    updateSlot(slot2, result.slots[1], 2)
    updateSlot(slot3, result.slots[2], 3)

    if (result.winning_roll) {
      showWinningMessage(result.credits_won)
    }
  } catch (error) {
    console.error('Error:', error)
    alert('An error occurred while fetching roll results')
  }
})
hideWinningMessage()
