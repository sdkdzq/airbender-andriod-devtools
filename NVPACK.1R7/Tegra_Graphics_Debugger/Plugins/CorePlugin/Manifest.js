// CorePlugin: Provides most of the common Agora UI elements.
// Prefer adding shared UI code to this plugin instead of the AppLib static library.
AppLib.logInfo("Loading CorePlugin");

// ----------------------------------------------------------------------------
// Important: These states need to match the ones defined in CoreStates.h.
// ----------------------------------------------------------------------------
var states = {
    IsConnected: "$$.IsConnected",
    IsDebug: "$$.IsDebug",
};

addPlugin({
    pluginDependencies: [],
    pluginLibrary: "CorePlugin", // Library suffix (.so, .dll) appended automatically

    toolWindows: {
        "$$.LogWindow": {
            text: qsTr("Output Messages"),
            layout: "dockSouth",
            persistable: true,
            commandBars: {
                "$$.LogWindowToolbar": { order: 1000 }
            },
            properties: {
                columns: {
                    "ID": { visible: true },
                    "Type": { visible: true },
                    "Origin": { visible: true },
                    "Source": { visible: true },
                    "Message": { visible: true },
                },
            },
        },

        "$$.DocumentsWindow": {
            text: qsTr("Documents"),
            sizeMode: "percent",
            defaultHeight: 50,
            defaultWidth: 50,
            deleteOnClose: true,
            isFixed: true,
            preservesContents: true,
            persistable: true,
            layout: "dockEast",
        },

        "$$.SecondaryDocumentsWindow": {
            text: qsTr("Documents"),
            sizeMode: "percent",
            defaultHeight: 50,
            defaultWidth: 50,
            deleteOnClose: true,
            isFixed: true,
            preservesContents: true,
            persistable: false,
            layout: "floating",
        },
    },

    documentWells: {
        main: {
            closeWhenEmpty: false
        },

        secondary: {
            // Not needed for now, but if needed later config could go here. 
        },
    },

    commands: {

        // Project commands 
        "$$.NewProject": {
            text: qsTr("New Project..."),
            importance: "high",
        },
        "$$.OpenProject": {
            text: qsTr("Open Project..."),
            image: codeTr(":/Common/Open.png"),
            importance: "high",
        },
        "$$.SaveProject": {
            text: qsTr("Save Project"),
            image: codeTr(":/Common/Save.png"),
            importance: "high",
        },
        "$$.SaveProjectAs": {
            text: qsTr("Save Project As..."),
            image: codeTr(":/Common/SaveAs.png"),
            importance: "high",
        },
        "$$.RecentProjects": {
            text: qsTr("Recent Projects"),
        },

        // Document commands
        "$$.NewFile": {
            text: qsTr("&New..."),
            shortcut: codeTr("Ctrl+N"),
            importance: "high"
        },
        "$$.OpenFile": {
            text: qsTr("&Open..."),
            image: codeTr(":/Common/Open.png"),
            shortcut: codeTr("Ctrl+O"),
            importance: "high"
        },
        "$$.SaveFile": {
            text: qsTr("&Save"),
            image: codeTr(":/Common/Save.png"),
            shortcut: codeTr("Ctrl+S"),
            importance: "high"
        },
        "$$.SaveFileAs": {
            text: qsTr("Save &As..."),
            image: codeTr(":/Common/SaveAs.png"),
            importance: "high"
        },
        "$$.SaveAllFiles": {
            text: qsTr("Save A&ll"),
            image: codeTr(":/Common/SaveAll.png"),
            shortcut: codeTr("Ctrl+Shift+S"),
            importance: "high"
        },
        "$$.CloseFile": {
            text: qsTr("&Close"),
            shortcut: codeTr("Ctrl+W"),
            importance: "high"
        },

        // General file commands
        "$$.ExitCommand": {
            text: qsTr("E&xit"),
            image: codeTr(":/Common/Exit.png"),
        },

        // Window commands
        // NOTE: Battle & Rebel have their own product specific window commands (but should really use this)
        "$$.ExportWindowLayout": {
            visibleWithFlags: [states.IsDebug],
            text: qsTr("Export Window Layout"),
        },
        "$$.ResetWindowLayout": {
            text: qsTr("&Reset Window Layout"),
        },

        // Connection commands
        // DEPRECATED: Prefer TPSConnectionPlugin
        "$$.ConnectCommand": {
            text: qsTr("&Connect..."),
            image: codeTr(":/Common/Connect.png"),
            importance: "high",
            requiresFlags: [not(states.IsConnected)],
            shortcut: codeTr("Ctrl+Shift+C"),
        },
        "$$.DisconnectCommand": {
            text: qsTr("&Disconnect"),
            image: codeTr(":/Common/Disconnect.png"),
            importance: "high",
            requiresFlags: [states.IsConnected],
            shortcut: codeTr("Ctrl+Shift+D"),
        },

        "$$.SettingsCommand": {
            text: qsTr("&Options..."),
            shortcut: codeTr("F7"),
        },
        "$$.ShowLogsCommand": {
            text: qsTr("Output &Messages"),
        },
        "$$.ExportLogsCommand": {
            text: qsTr("Export to CSV"),
            imageFontIcon: "fa-floppy-o",
        },
        "$$.ClearLogsCommand": {
            text: qsTr("Clear"),
            imageFontIcon: "fa-trash",
            importance: "high"
        },
        "$$.ShowInfoLogLevelCommand": {
            text: qsTr("Show &Info Messages"),
            image: codeTr(":/NV_UI/info.png"),
            checked: true
        },
        "$$.ShowWarningLogLevelCommand": {
            text: qsTr("Show &Warning Messages"),
            image: codeTr(":/NV_UI/warning.png"),
            checked: true
        },
        "$$.ShowErrorLogLevelCommand": {
            text: qsTr("Show &Error Messages"),
            image: codeTr(":/NV_UI/error.png"),
            checked: true
        },
        "$$.ShowFatalLogLevelCommand": {
            text: qsTr("Show &Fatal Messages"),
            image: codeTr(":/NV_UI/fatal.png"),
            checked: true
        },
        "$$.FilterLogSourceCommand": {
            text: qsTr("Filter &Sources:"),
            editable: true,
            type: "list",
            width: 30
        },
        "$$.AboutCommand": {
            text: qsTr("&About..."),
            menuRole: "about",
        },
        "$$.DocumentationCommand": {
            text: qsTr("&Documentation..."),
        },
        "$$.SelectPreviousCommand": {
            text: qsTr("Select &Previous"),
            shortcut: codeTr("Ctrl+Left"),
        },
        "$$.SelectNextCommand": {
            text: qsTr("Select &Next"),
            shortcut: codeTr("Ctrl+Right"),
        },
        "$$.SelectFirstCommand": {
            text: qsTr("Select &First"),
            shortcut: codeTr("Ctrl+Home"),
        },
        "$$.SelectLastCommand": {
            text: qsTr("Select &Last"),
            shortcut: codeTr("Ctrl+End"),
        },
    },

    commandGroups: {

        // NOTE: Not a default group in the FileMenu
        "$$.ProjectGroup": {
            "$$.NewProject": { order: 100 },
            "$$.OpenProject": { order: 110 },
            "$$.SaveProject": { order: 120 },
            "$$.SaveProjectAs": { order: 130 },
            "$$.RecentProjects": { order: 140 },
        },

        // NOTE: Not a default group in the FileMenu
        "$$.FileGroup": {
            "$$.NewFile": { order: 100 },
            "$$.OpenFile": { order: 110 },
            "$$.SaveFile": { order: 120 },
            "$$.SaveFileAs": { order: 130 },
            "$$.SaveAllFiles": { order: 140 },
            "$$.CloseFile": { order: 150 },
        },

        // NOTE: Battle & Rebel have their own product specific layout group (but should really use this)
        "$$.LayoutGroup": {
            "$$.ExportWindowLayout": { order: 99 },
            "$$.ResetWindowLayout": { order: 100 },
        },

        "$$.ExitGroup": {
            "$$.ExitCommand": { order: 100 }
        },
        "$$.SettingsGroup": {
            "$$.SettingsCommand": { order: 100 },
        },
        "$$.FileCloseGroup": {
            "$$.CloseDocumentCommand": { order: 100 }
        },
        "$$.ConnectionGroup": {
            "$$.ConnectCommand": { order: 100 },
            "$$.DisconnectCommand": { order: 110 },
        },
        "$$.LogViewGroup": {
            "$$.ShowLogsCommand": { order: 100 }
        },
        "$$.LogClearGroup": {
            "$$.ExportLogsCommand": { order: 100 },
            "$$.ClearLogsCommand": { order: 110 },
        },
        "$$.LogFilterGroup": {
            "$$.ShowInfoLogLevelCommand": { order: 100 },
            "$$.ShowWarningLogLevelCommand": { order: 110 },
            "$$.ShowErrorLogLevelCommand": { order: 120 },
            "$$.ShowFatalLogLevelCommand": { order: 130 },
        },
        "$$.LogSourceFilterGroup": {
            "$$.FilterLogSourceCommand": { order: 100 }
        },
        "$$.DocumentationGroup": {
            "$$.DocumentationCommand": { order: 100 },
        },
        "$$.AboutGroup": {
            "$$.AboutCommand": { order: 100 },
        },
    },

    commandBars: {
        "$$.FileMenu": {
            type: "menu",
            text: qsTr("&File"),
            commandGroups: {
                "$$.ExitGroup": { order: 100 },
            },
        },
        "$$.ConnectionMenu": {
            type: "menu",
            text: qsTr("&Connection"),
            commandGroups: {
                "$$.ConnectionGroup": { order: 100 },
            },
        },
        "$$.ToolsMenu": {
            type: "menu",
            text: qsTr("&Tools"),
            commandGroups: {
                "$$.LogViewGroup": { order: 100 },
                "$$.SettingsGroup": { order: 110 },
            },
        },

        // NOTE: Battle & Rebel have their own product specific window menu (but should really use this)
        "$$.WindowMenu": {
            type: "menu",
            text: qsTr("&Window"),
            commandGroups: {
                "$$.LayoutGroup": { order: 100 },
            },
        },

        "$$.HelpMenu": {
            type: "menu",
            text: qsTr("&Help"),
            commandGroups: {
                "$$.DocumentationGroup": { order: 100 },
                "$$.AboutGroup": { order: 110 },
            },
        },
        "$$.ConnectionToolbar": {
            type: "toolbar",
            text: qsTr("Connection"),
            commandGroups: {
                "$$.ConnectionGroup": { order: 100 },
            },
        },
        "$$.LogWindowToolbar": {
            type: "toolbar",
            text: qsTr("Main"),
            commandGroups: {
                "$$.LogClearGroup": { order: 100 },
                "$$.LogFilterGroup": { order: 110 },
                "$$.LogSourceFilterGroup" : { order: 120 }
            }
        },
    },

    themes: {
        // There is no Default Theme file. It simply uses the default palette.
        "DefaultTheme" : {},
        "LightTheme" : AppLib.require("LightTheme.js"),
        "DarkTheme" : AppLib.require("DarkTheme.js"),
        "BlueTheme" : AppLib.require("BlueTheme.js"),
    },

    settings: {
        "Environment": {
            order: 50,
            text: qsTr("Environment"),
            properties: {
                "ColorTheme": {
                    order: 100,
                    type: "enum",
                    category: qsTr("Visual Experience"),
                    text: qsTr("Color Theme"),
                    defaultValue: "DefaultTheme",
                    detailsText: qsTr("The currently selected application color theme."),
                    enumValues: {
                        "DefaultTheme": {
                            order: 100,
                            text: qsTr("Default"),
                        },
                        "LightTheme": {
                            order: 200,
                            text: qsTr("Light"),
                        },
                        "DarkTheme": {
                            order: 300,
                            text: qsTr("Dark"),
                        },
                        "BlueTheme": {
                            order: 400,
                            text: qsTr("Blue"),
                        },
                    },
                },
            },
        },
    },

});

// Rename some commands for increased Mac integration
if (AppLib.environment.darwin) {
    addPlugin({
        commands: {
            "CorePlugin.ExitCommand": {
                shortcut: codeTr("Ctrl+Q"),
                menuRole: "quit",
            },
            "CorePlugin.SettingsCommand": {
                text: qsTr("Preferences..."),
                shortcut: codeTr("Ctrl+,"),
                menuRole: "preferences",
            },
        },
    });
}
