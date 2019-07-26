// DO NOT MODIFY.
// This file was created automatically by CMake.

// QuadDPlugin is the primary UI library for the product.
AppLib.logInfo("Loading QuadDPlugin");

var states = {
    ShowProjectExplorer: "$$.ShowProjectExplorer",
};

addPlugin({
    pluginDependencies: ["CorePlugin"],
    pluginLibrary: "QuadDPlugin",

    layouts: {
        "default": "Plugins/$$/default.layout",
    },

    hostApplication: {
        title: qsTr("NVIDIA System Profiler 3.9"),
        defaultWidth: 1366,
        defaultHeight: 768,
        multiTargetEnabled: true,

        productName: "NVIDIA System Profiler",
        productVersion: "3.9",
        organizationName: "NVIDIA Corporation",

        commandBars: {
            "$$.FileMenu": { order: 100 },
            "$$.ViewMenu": { order: 200 },
            // "$$.ToolsMenu": { order: 300 },
            "$$.HelpMenu": { order: 9999 },
            "$$.DeviceListToolbar": { order: 400 },
        },
    },

    documents:
    {
        fileTypes:
        {
            "qdrep":
            {
                icon: "",
                factoryName: "ReportFactory",
                viewFactories:
                [
                    { factoryName: "ReportWindowFactory", priority: 50 }
                ]
            },
            "qdproj":
            {
                icon: "",
                factoryName: "ProjectFactory",
                viewFactories:
                [
                    { factoryName: "ProjectWindowFactory", priority: 50 }
                ]
            },
            "qdprogress":
            {
                icon: "",
                factoryName: "ProfilingProgressFactory",
                viewFactories:
                [
                    { factoryName: "ProfilingProgressWindowFactory", priority: 50 }
                ]
            },
        },
        fileFilters: {
            "Projects": { extensions: ["qdproj"], sortPriority: 50 },
            "Reports": { extensions: ["qdrep"], sortPriority: 50 }
        }
    },

    toolWindows: {
        "$$.ProjectExplorerWindow": {
            text: qsTr("Project Explorer"),
            sizeMode: "percent",
            deleteOnClose: true,
            layout: "dockWest",
            isFixed: false,
            persistable: true,
            defaultWidth: 250,
            commandBars: {
            },
        }

    },

    commands: {
        "$$.RestoreDefaultLayout": {
            text: qsTr("&Restore Default Layout"),
        },
        "$$.SaveLayout": {
            text: qsTr("&Save Layout"),
        },
        "$$.NewProject": {
            text: qsTr("&New Project"),
            shortcut: codeTr("Ctrl+N"),
        },
        "$$.OpenFile": {
            text: qsTr("&Open..."),
            shortcut: codeTr("Ctrl+O"),
        },
        "$$.SaveFileAs": {
            text: qsTr("Save &As..."),
            shortcut: codeTr("Ctrl+Shift+S"),
            enabled: false,
        },
        "$$.ShowProjectExplorer": {
            text: qsTr("&Show Project Explorer"),
            checkedWithFlags: [states.ShowProjectExplorer],
        },
        "$$.ShowAboutWindow": {
            text: qsTr("&About"),
        },
        "$$.ShowPreferencesWindow": {
            text: qsTr("&Preferences..."),
        },
    },

    commandGroups: {
        "$$.ProjectGroup": {
            "$$.NewProject": { order: 100 },
            "$$.OpenFile": { order: 200 },
        },
        "$$.ViewToolWindowsGroup": {
            "$$.ShowProjectExplorer": { order: 100 },
        },
        "$$.HelpGroup": {
            "$$.ShowAboutWindow": { order: 100 },
        },
        "$$.LayoutGroup": {
            "$$.RestoreDefaultLayout": { order: 110 },
            "$$.SaveLayout": { order: 110 },
        }
    },

    commandBars: {
        "$$.FileMenu": {
            type: "menu",
            text: qsTr("&File"),
            commandGroups: {
                "$$.ProjectGroup": { order: 100 },
                "CorePlugin.ExitGroup": { order: 200 },
            },
        },
        "$$.ViewMenu": {
            type: "menu",
            text: qsTr("&View"),
            commandGroups: {
                "$$.ViewToolWindowsGroup": { order: 100 },
                "$$.LayoutGroup": { order: 210 },
            },
        },
        "$$.HelpMenu": {
            type: "menu",
            text: qsTr("&Help"),
            commandGroups: {
                "$$.HelpGroup": { order: 100 },
            },
        },
        "$$.ToolsMenu": {
            type: "menu",
            text: qsTr("&Tools"),
            commandGroups: {
                "CorePlugin.SettingsGroup": { order: 100 },
            },
        },
        "$$.DeviceListToolbar": {
            type: "toolbar",
            text: qsTr("Device List"),
            commandGroups: {
            }
        },
    },
});
