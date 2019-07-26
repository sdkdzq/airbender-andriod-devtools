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
        { signal: "gr__busy_pct", color: "#76b900" },
        { signal: "ia__busy_pct_avg", color: "#f0a000" },
        { signal: "sm__busy_pct_avg", color: "#377eb8" },
        { signal: "tex__busy_pct_avg", color: "#e41a1c" },
    ],

    // window 3
    [
        { signal: "sm__active_cycles_vs_pct", color: "#76b900" },
        { signal: "sm__active_cycles_tcs_pct", color: "#f0a000" },
        { signal: "sm__active_cycles_tes_pct", color: "#377eb8" },
        { signal: "sm__active_cycles_gs_pct", color: "#e41a1c" },
        { signal: "sm__active_cycles_fs_pct", color: "#984ea3" },
        { signal: "sm__active_cycles_cs_pct", color: "#1cc3e5" },
    ],

]