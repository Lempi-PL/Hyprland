# 🌌 Cyber-Wayland: Hyprland Lua Dotfiles (2026 Edition)

Welcome to my custom Wayland desktop environment! This repository contains a modern, highly optimized configuration for **Hyprland** using the native **Lua API** (standard in 2026), paired with a beautiful dual-bar **Waybar** setup and a deep **TokyoNight** aesthetic.

This guide will walk you through swapping your default GUI for this custom setup, step by step.

---

## 📦 1. Prerequisites & Installation

Before applying the configurations, we need to install the core compositor, essential tools, and theming packages. 

### Official Packages (pacman)
Open your terminal and run the following command to install the required packages from the official Arch repositories:

```bash
sudo pacman -S hyprland kitty thunar waybar dunst hyprpaper wofi wlogout flameshot grim nwg-look papirus-icon-theme ttf-jetbrains-mono-nerd stow pavucontrol gsimplecal network-manager-applet
```
* **Core & Terminal:** `hyprland`, `kitty`, `thunar`
* **Desktop Components:** `waybar` (status bars), `dunst` (notifications), `hyprpaper` (wallpapers), `wofi` (app launcher), `wlogout` (power menu)
* **Screenshot Utilities:** `flameshot` (area selection), `grim` (fullscreen capture)
* **Theming:** `nwg-look` (GTK settings), `papirus-icon-theme`, `ttf-jetbrains-mono-nerd` (fonts for icons in Waybar/Terminal)
* **Applets:** `pavucontrol` (audio GUI), `gsimplecal` (calendar GUI), `network-manager-applet` (nm-applet)

### AUR Packages (yay)
Next, install the GTK theme and the authentication agent from the Arch User Repository:

```bash
yay -S tokyonight-gtk-theme-git hyprpolkitagent
```
* **`tokyonight-gtk-theme-git`**: The gorgeous dark theme with neon blue accents.
* **`hyprpolkitagent`**: Crucial for GUI root password prompts (e.g., when opening GParted).

---

## 🚀 2. Applying the Dotfiles

We use **GNU Stow** to manage these dotfiles. It creates symbolic links from this repository directly to your `~/.config` folder, keeping everything clean and version-controlled.

1. **Clone this repository:**
   ```bash
   git clone https://github.com/Lempi-PL/Hyprland ~/Hyprland
   cd ~/Hyprland
   ```
2. **Deploy the configurations:**
   ```bash
   stow hyprland waybar terminal notifications filemanager gtk shell
   ```
3. **Enable Waybar Systemd Service:**
   Since our Hyprland config expects Waybar to be managed by systemd, enable it:
   ```bash
   systemctl --user enable --now waybar.service
   ```

---

## 🎨 3. Setting up the Theme (nwg-look)

Because Thunar and other apps rely on GTK, we need to apply the TokyoNight theme globally.

1. Open your terminal and type `nwg-look`.
2. In the **Widgets** tab, select `Tokyonight-Dark`.
3. In the **Icon theme** tab, select `Papirus-Dark`.
4. Click **Apply**. 

*Note: The `hyprland.lua` script also forces this theme via `gsettings` on startup to ensure consistency across all Wayland apps.*

---

## 📂 4. Configuration Breakdown (How it works)

Here is a detailed explanation of the files and scripts included in this repository.

### `hyprland/hyprland.lua` (The Core)
Instead of the old `.conf` format, this setup uses the modern **Lua API** for Hyprland, allowing for advanced logic:
* **Autostart:** Automatically launches `nm-applet`, `dunst`, `hyprpaper`, and the `hyprpolkitagent`.
* **Look & Feel:** Configured with `0` gaps, `10px` rounding, and a neon blue/green animated border (`rgba(33ccffee)` to `rgba(00ff99ee)`). Blur and shadows are enabled for a frosted glass effect.
* **Animations:** Custom bezier curves (`easeOutQuint`, `spring`) make window opening and workspace switching feel incredibly snappy and bouncy.
* **Waybar Sync Logic:** Contains a custom Lua function (`sync_waybar_workspace`) that listens to workspace changes and sends a `SIGRTMIN+8` signal to Waybar. This updates the sidebar instantly without relying on resource-heavy polling!

### `waybar/config.jsonc` (Dual Bar Setup)
The Waybar configuration is split into two distinct bars:
1. **Topbar (`mode: dock`):** Displays system vitals (CPU, Temp, RAM, Battery), the Clock, System Tray, and interactive modules for Brightness, Mic, Audio, and Network.
2. **Sidebar (`position: left`):** Acts as a dock. It contains custom workspace buttons (1-6) that sync perfectly with Hyprland via our Lua script, alongside quick-launch icons for Kitty, Thunar, VS Code, Firefox, Discord, and Wofi.

### Custom Scripts (`~/.config/hypr/*.sh`)
* **`toggle-topbar.sh` & `toggle-sidebar.sh`**: Triggered by `SUPER + G` and `SUPER + SHIFT + G`. They send `SIGUSR1` and `SIGUSR2` to Waybar to hide/show the bars independently.
* **`brightness.sh`**: Handles screen brightness via media keys and sends the progress bar to `dunst`.
* **`screenshot.sh`**: Handles full-screen captures using `grim`.
* **`focus.sh`**: A smart script used in the sidebar. If an app (like Firefox) is already open, clicking its icon focuses the window instead of opening a duplicate.
* **`workspace-state.sh`**: Reads the active workspace from `/tmp/hypr-waybar-active-workspace` to highlight the correct button on the sidebar.

---

## ⌨️ 5. Keybindings Reference

The `SUPER` key (Windows/Command key) is your main modifier.

### 🖥️ Core Apps
| Shortcut | Action |
| :--- | :--- |
| `SUPER + T` | Open Terminal (**Kitty**) |
| `SUPER + F` | Open File Manager (**Thunar**) |
| `SUPER + B` | Open Browser (**Firefox**) |
| `SUPER + E` | Open Editor (**VS Code**) |
| `SUPER + S` | Open App Launcher (**Wofi**) |
| `SUPER + C` | Close active window |
| `SUPER + ESC` | Exit/Shutdown Hyprland |

### 🪟 Window Management
| Shortcut | Action |
| :--- | :--- |
| `SUPER + V` | Toggle floating window |
| `SUPER + P` | Toggle pseudo-tiling |
| `SUPER + J` | Toggle split direction (Dwindle) |
| `SUPER + Arrows` | Move focus (Left/Right/Up/Down) |
| `SUPER + LMB` *(Drag)* | Move floating window |
| `SUPER + RMB` *(Drag)* | Resize window |

### 🚀 Workspaces & UI
| Shortcut | Action |
| :--- | :--- |
| `SUPER + [1-0]` | Switch to workspace 1-10 |
| `SUPER + SHIFT + [1-0]` | Move active window to workspace 1-10 |
| `SUPER + Mouse Scroll` | Scroll through existing workspaces |
| `SUPER + M` | Toggle Special Workspace (Magic/Scratchpad) |
| `SUPER + SHIFT + M` | Move window to Special Workspace |
| `SUPER + G` | Toggle **Top Bar** visibility |
| `SUPER + SHIFT + G` | Toggle **Sidebar** visibility |

### 📸 Media & Screenshots
| Shortcut | Action |
| :--- | :--- |
| `Print Screen` | Select area to screenshot (**Flameshot**) |
| `SUPER + Print Screen` | Fullscreen screenshot |
| `Media Keys` | Volume Up/Down/Mute, Mic Mute, Brightness |
| `Media Playback` | Play/Pause, Next, Previous (Requires `playerctl`) |

---

## 📚 Useful Resources
If you want to dive deeper into customizing this setup, check out the official documentation:
* [Hyprland Master Tutorial](https://wiki.hypr.land/Getting-Started/Master-Tutorial/)
* [Hyprland Useful Utilities](https://wiki.hypr.land/Useful-Utilities/Must-have/)

Enjoy your new, blazing-fast Wayland desktop! 🚀
