// CorePlugin: Provides most of the common Agora UI elements.
// Prefer adding shared UI code to this plugin instead of the AppLib static library.
AppLib.logInfo("Loading CorePlugin");
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
            }
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

        "$$.TearoffDocumentsWindow": {
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

        "$$.ColorPaletteViewerWindow": {
            text: qsTr("Color Palette Viewer"),
            sizeMode: "percent",
            defaultHeight: 50,
            defaultWidth: 50,
            deleteOnClose: true,
            persistable: false,
            layout: "floating",
        },  
    },

    commands: {
        "$$.NewFile": {
            text: qsTr("&New..."),
            shortcut: codeTr("Ctrl+N"),
            importance: "high"
        },

        "$$.OpenFile": {
            text: qsTr("&Open..."),
            image: codeTr("Plugins/$$/Open.png"),
            shortcut: codeTr("Ctrl+O"),
            importance: "high"
        },

        "$$.SaveFile": {
            text: qsTr("&Save"),
            image: codeTr("Plugins/$$/Save.png"),
            shortcut: codeTr("Ctrl+S"),
            importance: "high"
        },

        "$$.SaveFileAs": {
            text: qsTr("Save &As..."),
            image: codeTr("Plugins/$$/SaveAs.png"),
            importance: "high"
        },

        "$$.SaveAllFiles": {
            text: qsTr("Save A&ll"),
            image: codeTr("Plugins/$$/SaveAll.png"),
            shortcut: codeTr("Ctrl+Shift+S"),
            importance: "high"
        },

        "$$.CloseFile": {
            text: qsTr("&Close"),
            importance: "high"
        },

        "$$.ExitCommand": {
            text: qsTr("E&xit"),
            image: codeTr("Plugins/$$/Exit.png"),
        },
        "$$.SettingsCommand": {
            text: qsTr("&Options..."),
            shortcut: codeTr("F7"),
        },
        "$$.ShowColorPalette": {
            text: qsTr("&Color Options"),
        },
        "$$.CloseDocumentCommand": {
            text: qsTr("&Close"),
            shortcut: codeTr("Ctrl+W"),
            enabled: false,
        },
        "$$.ShowLogsCommand": {
            text: qsTr("Output &Messages"),
        },
        "$$.ClearLogsCommand": {
            text: qsTr("Clear"),
            image: codeTr("Plugins/$$/ClearLogs.png"),
            importance: "high"
        },
        "$$.ShowInfoLogLevelCommand": {
            text: qsTr("Show &Info Messages"),
            image: codeTr("Plugins/$$/LogIcon_Info.png"),
            checked: true
        },
        "$$.ShowWarningLogLevelCommand": {
            text: qsTr("Show &Warning Messages"),
            image: codeTr("Plugins/$$/LogIcon_Warning.png"),
            checked: true
        },
        "$$.ShowErrorLogLevelCommand": {
            text: qsTr("Show &Error Messages"),
            image: codeTr("Plugins/$$/LogIcon_Error.png"),
            checked: true
        },
        "$$.ShowFatalLogLevelCommand": {
            text: qsTr("Show &Fatal Messages"),
            image: codeTr("Plugins/$$/LogIcon_Fatal.png"),
            checked: true
        },
        "$$.FilterLogSourceCommand": {
            text: qsTr("Filter &Sources:"),
            editable: true,
            type: "list",
            width: 30
        }
    },

    commandGroups: {
        "$$.FileGroup": {
            "$$.NewFile": { order: 100 },
            "$$.OpenFile": { order: 110 },
            "$$.SaveFile": { order: 120 },
            "$$.SaveFileAs": { order: 130 },
            "$$.SaveAllFiles": { order: 140 },
            "$$.CloseFile": { order: 150 },
        },
        "$$.ExitGroup": {
            "$$.ExitCommand": { order: 100 }
        },
        "$$.SettingsGroup": {
            "$$.SettingsCommand": { order: 100 },
            "$$.ShowColorPalette": { order: 110 },
        },
        "$$.FileCloseGroup": {
            "$$.CloseDocumentCommand": { order: 100 }
        },
        "$$.LogViewGroup": {
            "$$.ShowLogsCommand": { order: 100 }
        },
        "$$.LogClearGroup": {
            "$$.ClearLogsCommand": { order: 100 }
        },
        "$$.LogFilterGroup": {
            "$$.ShowInfoLogLevelCommand": { order: 100 },
            "$$.ShowWarningLogLevelCommand": { order: 110 },
            "$$.ShowErrorLogLevelCommand": { order: 120 },
            "$$.ShowFatalLogLevelCommand": { order: 130 },
        },
        "$$.LogSourceFilterGroup": {
            "$$.FilterLogSourceCommand": { order: 100 }
        }
    },

    commandBars: {
        "$$.LogWindowToolbar": {
            type: "toolbar",
            text: qsTr("Main"),
            commandGroups: {
                "$$.LogClearGroup": { order: 100 },
                "$$.LogFilterGroup": { order: 110 },
                "$$.LogSourceFilterGroup" : { order: 120 }
            }
        }
    }
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
