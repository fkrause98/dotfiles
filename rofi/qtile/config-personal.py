# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
import os
import time
import subprocess
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

from typing import List  # noqa: F401

USER = os.getenv("USER")  # <- same as "echo $USER"
HOME = os.getenv("HOME")  # <- /home/$USER
FONDO = "/Imágenes/Fondos/Fondo.jpg"
META = "mod1"
SUPER = "mod4"
separator = widget.Sep()
BINARIES = "/usr/bin/"
if os.path.exists(HOME + FONDO):
    WALLPAPER = HOME + FONDO

# Executes a script at startup


# @hook.subscribe.startup_once


def autostart():
    script = HOME + "/.config/qtile/autostart.sh"
    time.sleep(5)
    subprocess.call([script])


keys = [
    # Switch between windows in current stack pane
    Key([META], "j", lazy.layout.down()),
    Key([META], "k", lazy.layout.up()),
    Key([META], "h", lazy.layout.left()),
    Key([META], "l", lazy.layout.right()),
    # Move windows up or down in current stack
    Key([META, "shift"], "j", lazy.layout.shuffle_down()),
    Key([META, "shift"], "k", lazy.layout.shuffle_up()),
    Key([META, "shift"], "l", lazy.layout.shuffle_right()),
    Key([META, "shift"], "h", lazy.layout.shuffle_left()),
    # Control the size of windows in MonadTall
    Key([META], "g", lazy.layout.grow()),
    Key([META], "m", lazy.layout.shrink()),
    Key([META, "shift"], "n", lazy.layout.normalize()),
    Key([SUPER, "shift"], "f", lazy.window.toggle_floating()),
    # Control the size of windows in Columns layout
    # Key([META, "control"], "l", lazy.layout.grow_right()),
    # Key([META, "control"], "h", lazy.layout.grow_left()),
    # Switch window focus to other pane(s) of stack
    Key([META], "space", lazy.layout.next()),
    Key([META, "shift"], "space", lazy.layout.flip()),
    # Swap panes of split stack
    # Key([META, "shift"], "space", lazy.layout.rotate()),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([META, "shift"], "Return", lazy.layout.toggle_split()),
    Key([META], "Return", lazy.spawn("kitty")),
    # Toggle between different layouts as defined below
    Key([META], "Tab", lazy.next_layout()),
    Key([META], "w", lazy.window.kill()),
    Key([META, "control"], "r", lazy.restart(), autostart()),
    Key([META, "control"], "q", lazy.shutdown()),
    # Key([META], "r", lazy.spawncmd()),
    Key(
        [META],
        "r",
        lazy.spawn(
            "rofi -show drun "
            "-show-icons -icon-theme Suru++ Ubuntu "
            "-font 'Firacode 15' -width 85"
        ),
        desc="Rofi Application Launcher",
    ),
    Key(
        [META, "shift"],
        "r",
        lazy.spawn("rofi -show run " "-font 'Firacode 15' -width 85"),
        desc="Rofi Run Launcher",
    ),
    # Screencap
    Key([], "Print", lazy.spawn("flameshot gui")),
    # Sound, use if no mediakeys are available.
    Key(["shift"], "F10", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key(["shift"], "F12", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    Key(["shift"], "F11", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    Key(["shift"], "F6", lazy.spawn("mpc toggle")),
    Key(["shift"], "F8", lazy.spawn("mpc stop")),
    Key(["shift"], "F7", lazy.spawn("mpc next")),
    Key(["shift"], "F5", lazy.spawn("mpc prev"))
    # Sound, use if mediakeys are available.
    # Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute 0 toggle")),
    # Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +5%")),
    # Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -5%")),
    # Key([], "XF86AudioPlay", lazy.spawn("mpc toggle")),
    # Key([], "XF86AudioStop", lazy.spawn("mpc stop")),
    # Key([], "XF86AudioNext", lazy.spawn("mpc next")),
    # Key([], "XF86AudioPrev", lazy.spawn("mpc prev")),
]

groups = "asdfuiop"

group_commands = {
    "Telegram": "telegram-desktop",
    "Firefox": "firefox",
    "Emacs": "emacs -nw",
    "Música": "vimpc",
}
groups = [Group(i) for i in groups]
for k in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key([META], k, lazy.group[k.name].toscreen()),
            # mod1 + shift + letter of group = switch to & move focused window
            # to group
            Key([META, "shift"], k, lazy.window.togroup(k.name, switch_group=True)),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([META, "shift"], i.name, lazy.window.togroup(i.name)),
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
)
layouts = [
    layout.Max(),
    # layout.Stack(num_stacks=2, margin=7),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    layout.Columns(**layout_config),
    # layout.Matrix(),
    layout.MonadTall(**layout_config),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Cantarell Bold",
    fontsize=16,
    padding=3,
    background="3B4252",
)

# def mpc_text():
#     while True:
#         mpc_actual=os.system("mpc current")
#         time.sleep(5)
#         print(mpc_actual)

extension_defaults = widget_defaults.copy()
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                # widget.TextBox(text=),
                separator,
                widget.CPU(),
                separator,
                widget.Memory(),
                separator,
                widget.CheckUpdates(update_interval=1),
                separator,
                widget.Pomodoro(color_inactive="#FFFFFF"),
                separator,
                widget.Volume(),
                separator,
                widget.Systray(),
                separator,
                widget.Clock(format="%Y-%d-%m %a %I:%M %p"),
            ],
            24,
        ),
        wallpaper=WALLPAPER,
        wallpaper_mode="fill",
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [META],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [META], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([META], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        {"wmclass": "win0"},
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": "download"},
        {"wmclass": "error"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},  # gitk
        {"wmclass": "makebranch"},  # gitk
        {"wmclass": "maketag"},  # gitk
        {"wname": "branchdialog"},  # gitk
        {"wname": "pinentry"},  # GPG key password entry
        {"wmclass": "ssh-askpass"},  # ssh-askpass
        {"wmclass": "pavucontrol"},  # ssh-askpass
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


autostart()
