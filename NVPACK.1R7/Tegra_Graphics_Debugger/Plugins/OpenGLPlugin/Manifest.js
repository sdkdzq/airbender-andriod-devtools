// Log loading message.
AppLib.logInfo("Loading OpenGL Plugin");

addPlugin({

    pluginLibrary: "OpenGLPlugin",
    pluginDependencies: ["CorePlugin", "BattlePlugin"],

    commands: {
    },

    commandGroups: {
    },

    commandBars: {
    },

    settings: {
    },
});
