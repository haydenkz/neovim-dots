return {
  "haydenzeller/nvim-wingman",
  lazy = false, -- Load immediately (recommended for real-time suggestions)
  dependencies = { "nvim-lua/plenary.nvim" }, -- Required for HTTP requests
  config = function()
    require("wingman").setup({
      api_key = "xai-BeYYCRDgBmPTiW4KxsSnDPXzPNtQZ1YiDA5hT3xMFIdl2Ebz33BMVWv7j8AtuiTogxeRtfPoJU4D5Kju", -- Replace with your xAI Grok API key
      useOllama = false,             -- Set to true to use Ollama instead of Grok
      model = "grok-2-latest",       -- Specify the model to use
      ollama_url = "http://localhost:11434", -- Ollama API endpoint
      grok_url = "https://api.x.ai/v1/chat/completions", -- Grok API endpoint
    })
  end,
}
