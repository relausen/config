return {
  "nvim-neotest/neotest",
  opts = {
    adapters = {
      ["neotest-dotnet"] = {
        discovery_root = "solution",
      },
    },
  },
}
