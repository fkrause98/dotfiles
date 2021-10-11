from typing import List  # noqa: F401
import os
import subprocess
from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

### Key Variables ###
meta_r = "mod5"
meta = "mod1"
win = "mod4"
shift = "shift"

### Variables  ###
terminal = "kitty"
home = os.getenv("HOME")
wallpaper = home + "/Imágenes/Fondos/Fondo.jpg"
config_folder = home + "/.config/qtile/"
auto_start_script = config_folder + "autostart.sh"
binaries = "/usr/bin/"
separator = widget.Sep()
run_command = "rofi -show run -font 'Firacode 15' -width 85"
run_program = (
    "rofi -show drun -show-icons "
    + "-icon-theme Suru++ Ubuntu -font 'Firacode 15' -width 85"
)

### Auto-start script ###
@hook.subscribe.startup_once
def autoStart():
    global auto_start_script
    subprocess.call([auto_start_script])


### Keybindings ###
keys = [
    # Window manager controls
    Key([meta, shift], "m", lazy.window.toggle_fullscreen()),
    Key([meta, shift], "space", lazy.layout.flip()),
    Key([meta], "w", lazy.window.kill()),
    Key([meta], "Return", lazy.spawn(terminal)),
    Key([meta], "t", lazy.window.toggle_floating()),
    Key([meta_r], "t", lazy.window.toggle_floating()),
    Key([meta], "Tab", lazy.next_layout()),


    # Move focus
    Key([meta], "space", lazy.layout.next()),
    Key([meta], "j", lazy.layout.down()),
    Key([meta], "k", lazy.layout.up()),
    Key([meta], "h", lazy.layout.left()),
    Key([meta], "l", lazy.layout.right()),

    # Move Windows
    Key([meta, shift],"j",lazy.layout.shuffle_down()),
    Key([meta, shift], "k", lazy.layout.shuffle_up()),
    Key([meta, shift], "h", lazy.layout.shuffle_left()),
    Key([meta, shift], "l", lazy.layout.shuffle_right()),


    # Alter window size
    Key([meta, "control"], "n", lazy.layout.normalize()),
    Key([meta, "control"], "g", lazy.layout.grow()),
    Key([meta, "control"], "m", lazy.layout.shrink()),
    Key([meta, "control"], "l", lazy.layout.grow_right()),
    Key([meta, "control"], "j", lazy.layout.grow_down()),
    Key([meta, "control"], "k", lazy.layout.grow_up()),
    Key([meta], "n", lazy.layout.normalize()),
    Key([meta, shift], "Return", lazy.layout.toggle_split()),

    # Toggle between different layouts as defined below
    Key([meta, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([meta, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Use rofi as a replacement for dmenu/qtile's spawn.
    Key([meta, shift], "r", lazy.spawn(run_command)),

    # Use rofi as an application launcher.
    Key([meta], "r", lazy.spawn(run_program)),


    # Screencap
    Key([win, shift], "s", lazy.spawn("flameshot gui")),


    # Sound control
    Key([shift], "F10", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key([shift], "F12", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    Key([shift], "F11", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    Key([shift], "F6", lazy.spawn("mpc toggle")),
    Key([shift], "F8", lazy.spawn("mpc stop")),
    Key([shift], "F7", lazy.spawn("mpc next")),
    Key([shift], "F5", lazy.spawn("mpc prev")),
]


# I'm using this as a reference:
# http://www.imgt.org/IMGTeducation/Aide-memoire/_UK/alphabetgrec.html
greek_letters = {
    "a": "Α",
    "s": "Σ",
    "d": "Δ",
    "f": "ɸ",
    "u": "Ψ",
    "i": "Ɩ",
    "o": "Ο",
    "p": "Π",
}
# groups = [Group(i) for i in "asdfuiop"]
groups = [
    Group(key, label=greek_letters[key], layout="MonadTall")
    for key in greek_letters.keys()
]

for i in groups:
    keys.extend(
        [
            # meta + letter of group = switch to group
            Key(
                [meta],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # win + shift + letter of group = switch to & move focused window to group
            Key(
                [win, shift],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # meta + shift + letter of group = move focused window to group
            Key(
                [meta, shift],
                i.name,
                lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name),
            ),
        ]
    )

border_config = dict(
    border_focus="#D8DEE9",
    border_focus_stack="#D8DEE9",
    border_width=2,
)

layout_config = dict(
    margin=10,
    **border_config,
    font="Ubuntu",
)

# Try more layouts by uncommenting below layouts.
layouts = [
    # layout.Columns(**layout_config),
    layout.Max(**layout_config),
    layout.MonadTall(**layout_config),
    layout.TreeTab(
        **layout_config, section_left=3, sections=["Section 1", "Section 2"]
    ),
    # layout.RatioTile(),
    # layout.Stack(num_stacks=3, **layout_config),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    layout.Tile(**layout_config, master_length = 1, shift_windows=True),
    # layout.VerticalTile(**layout_config),
    # layout.Zoomy(),
    # layout.Floating(),
]

widget_defaults = dict(
    font="Ubuntu",
    fontsize=16,
    padding=3,
    background="3B4252",
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(),
                widget.GroupBox(),
                widget.WindowName(),
                separator,
                widget.CPU(),
                separator,
                widget.Memory(),
                separator,
                # widget.CheckUpdates(update_interval=1),
                # separator,
                widget.Pomodoro(color_inactive="#FFFFFF"),
                separator,
                widget.Volume(
                    emoji=True,
                    mute_command="amixer -q -D pulse set Master toggle".split(),
                    volume_up_command="amixer -q -D pulse set Master 2%+".split(),
                    volume_down_command="amixer -q -D pulse set Master 2%-".split(),
                    get_volume_command="amixer -D pulse get Master".split(),
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(
                            "amixer -q -D pulse set Master toggle"
                        ),
                        "Button4": lambda: qtile.cmd_spawn(
                            "amixer -q -D pulse set Master 4%+"
                        ),
                        "Button5": lambda: qtile.cmd_spawn(
                            "amixer -q -D pulse set Master 4%-"
                        ),
                    },
                ),
                separator,
                widget.Systray(),
                separator,
                widget.Clock(format="%d-%m-%Y %a %I:%M %p"),
            ],
            24,
        ),
        wallpaper=wallpaper,
        wallpaper_mode="fill",
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [meta],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [meta], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([meta], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
