// Log loading message.
AppLib.logInfo("Loading Vulkan Plugin");

addPlugin({

    pluginLibrary: "VulkanPlugin",
    pluginDependencies: ["CorePlugin", "BattlePlugin"],

    overrides:{
        toolWindows: {
            "BattlePlugin.DirectedTestWindow": {
                showWarning: true,
            },
        },
    },

    toolWindows: {

        "$$.DeviceMemory": {
            text: qsTr("Vulkan Device Memory"),
            deleteOnClose: true,
            layout: "floating",
            defaultHeight: 512,
            defaultWidth: 512,
            persistable: true,
            commandBars: {
                "$$.DeviceMemoryToolbar": { order: 100 },
            },
        },

        "$$.DescriptorSets": {
            text: qsTr("Vulkan Descriptor Sets"),
            deleteOnClose: true,
            layout: "floating",
            defaultHeight: 512,
            defaultWidth: 512,
            persistable: true,
            commandBars: {
                "$$.DescriptorSetsToolbar": { order: 100 },
            },
        },

    },

    commands: {

        "$$.ShowDeviceMemory": {
            text: qsTr("Vulkan Device Memory"),
            shortcut: codeTr("Ctrl+M, Ctrl+M"),
            requiresFlags: ["BattlePlugin.FrameDebugging"],
            visibleWithFlags: ["BattlePlugin.FrameDebugging", "BattlePlugin.IsVulkanEvent"],
        },

        "$$.ShowDescriptorSets": {
            text: qsTr("Vulkan Descriptor Sets"),
            shortcut: codeTr("Ctrl+M, Ctrl+X"),
            requiresFlags: ["BattlePlugin.FrameDebugging"],
            visibleWithFlags: ["BattlePlugin.FrameDebugging", "BattlePlugin.IsVulkanEvent"],
        },
    },

    commandGroups: {

        "BattlePlugin.FrameDebuggerViewsGroup": {
            "$$.ShowDeviceMemory": { order: 500 },
            "$$.ShowDescriptorSets": { order: 520 },
        },
    },

    commandBars: {

        "$$.DeviceMemoryToolbar": {
            type: "toolbar",
            commandGroups: {
                "BattlePlugin.CloneLockGroup": { order: 100 },
            }
        },

        "$$.DescriptorSetsToolbar": {
            type: "toolbar",
            commandGroups: {
                "BattlePlugin.CloneLockGroup": { order: 100 },
            }
        },
    },

    settings: {
    },
});
