return {
    'mfussenegger/nvim-dap',
    config = function()
        require('dap.ext.vscode').load_launchjs()

        local dap = require('dap')
        dap.defaults.fallback.terminal_win_cmd = 'tabnew'
    end,
}
