// This file is an array of arrays of objects.
//
// The outer array is a list of windows. The first element is the window description
// for the first signal graph window opened, the second element for the second such
// window, and so on.
//
// The inner array is therefore the list of signals to display in that window. It is
// a list of objects of the following format:
//
//      signal (string): The name of the signal as reported by NvPmApi. Required.
//      text (string): This is how the graph is labeled in the window. Optional.
//          If not present, the signal name is used instead.
//      visible (boolean): Whether or not the signal is displayed by default.
//          Invisible signals are displayed "unchecked" in the graph legend.
//          Optional. If not present, defaults to true.
//      color (string): The color to use when drawing the signal.
//          Any string acceptable to QColor::QColor(const QString&) may be used.
//          Optional. If not present, defaults to black.
[
    // window 1
    [
        { signal: "FPS", color: "#76b900" },
    ],

    // window 2
    [
        { signal: "gpu_busy", color: "#76b900" },
        { signal: "geom_busy", color: "#f0a000" },
        { signal: "shader_busy", color: "#377eb8" },
        { signal: "texture_busy", color: "#e41a1c" },
    ],

    // window 3
    [
        { signal: "cpu_00_load", color: "#76b900" },
        { signal: "cpu_01_load", color: "#377eb8" },
        { signal: "cpu_02_load", color: "#984ea3" },
        { signal: "cpu_03_load", color: "#e41a1c" },
    ],
]