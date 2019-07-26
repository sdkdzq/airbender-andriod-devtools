AppLib.logInfo("Loading TegraGraphicsDebuggerPlugin");

// ----------------------------------------------------------------------------
// Important: These states need to match the ones defined in BattleStates.h.
// ----------------------------------------------------------------------------
var states = {
    // BattlePlugin states of interest
    frameDebugging: "BattlePlugin.FrameDebugging",
};

addPlugin({

    // About this plugin
    pluginDependencies: ["CorePlugin", "BattlePlugin"],
    pluginLibrary: "TegraGraphicsDebuggerPlugin",

    // Applicaiton specifications
    hostApplication: {

        // Meta information
        icon: codeTr(":/HostIcons/TegraGraphicsDebugger.ico"),
        title: qsTr("NVIDIA Tegra Graphics Debugger for Android"),
        version: "2.6",
        id: 6,
        docs: "http://docs.nvidia.com/tegra-graphics-debugger/2.6/index.html",
        defaultWidth: 1366,
        defaultHeight: 768,

        // Menu and Toolbar Order
        // ======================
        // 
        // Top-level menus and toolbars can be provided by both product-plugins
        // as well the functionality plugins.  In order to provide a consistent
        // experience across products, we have standardized on some well-known
        // menu items as and set aside a location into which functionality
        // plugins may inject their menus and toolbars.
        //
        // The standard is as follows:
        //
        // Menu                                             Order
        // ----                                             -----
        // File*                                            100
        // Connection*                                      200
        // [Reserved for Functionality Plugin additions]    500-999
        // Tools*                                           1300
        // Window*                                          1400
        // Help*                                            1500
        //
        // * indicates a well-known top-level menu.  For consistency, these
        //   items should exist in every product.
        // 
        // Toolbar order will be defined in a similar way.
        //
        // Toolbar                                     Order
        // -------                                     -----
        // Connection                                   200
        //
        // Note: TODO: (http://nv/fb/45409) Some of these standard menus and
        //       toolbars will be moved to a common location like Core.Plugin,
        //       but until then we can define them in each product plugin.
        //
        // We might want to consider using something like:
        //
        //     "$$.FileMenu": { order: Applib.Environment.FileMenuOrder }
        //
        // instead of hard-coding the numbers here.


        // As mentioned above, the product plugin would typically define all
        // the well-known top-level menus.  But since there are so many 
        // BattlePlugin based products, even the well-known menus are currently
        // being defined in BattlePlugin just so they do not need to be 
        // redefined in each product plugin.
        //
        // (Perhaps we can come up with a way to include a shared section of 
        // manifest file to eventually extract the common menu definitions out
        // of BattlePlugin.)
        //
        commandBars: {
            // Menus
            "BattlePlugin.FileMenu": { order: 100 },
            "CorePlugin.ConnectionMenu": { order: 200 },
            // Expected menus from functionality plugins:
            //   - BattlePlugin.FrameDebuggerMenu

            "BattlePlugin.ToolsMenu": { order: 1300 },
            "BattlePlugin.WindowMenu": { order: 1400 },
            "CorePlugin.HelpMenu": { order: 1500 },

            // Toolbars
            "BattlePlugin.GlobalCommands": { order: 0 },
            "CorePlugin.ConnectionToolbar": { order: 200 },
            "BattlePlugin.AdvancedConnectionToolbar": { order: 500 },
        },
    },

    overrides: {
        commands: {
            "CorePlugin.SelectPreviousCommand": {
                requiresFlags: [states.frameDebugging],
            },
            "CorePlugin.SelectNextCommand": {
                requiresFlags: [states.frameDebugging],
            },
            "CorePlugin.SelectFirstCommand": {
                requiresFlags: [states.frameDebugging],
            },
            "CorePlugin.SelectLastCommand": {
                requiresFlags: [states.frameDebugging],
            },
        },
    },

    layouts: {
        "default": "Plugins/$$/default.layout",
        "$$.Empty": "Plugins/$$/Empty.layout",
        "$$.Connected": "Plugins/$$/Connected.layout",
        "$$.Debugger": "Plugins/$$/FrameDebugging.layout",
    },

    // Product-specific commands
    commands: {
        // None.
    },

    // Product-specific command groups
    commandGroups: {
        // None.
    },

    // Product-specific command bars
    commandBars: {
        "BattlePlugin.ToolsMenu": {
            commandGroups: {
                // TODO: Move this functionality to the Options panel.
                "BattlePlugin.AdvancedOptionsGroup": { order: 120 },
            },
        },
    },

});

