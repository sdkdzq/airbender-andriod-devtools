// Log loading message.
AppLib.logInfo("Loading ConnectionPlugin");

var states = {
    connected: "ConnectionPlugin.Connected",
};

addPlugin({

    pluginLibrary: "ConnectionPlugin",
    pluginDependencies: ["CorePlugin"],

    commands: {
    },

    commandGroups: {
    },

    commandBars: {
    },

    settings: {
    },
});
