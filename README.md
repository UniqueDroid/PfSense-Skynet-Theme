# PfSense-Skynet-Theme

A dark theme for the pfSense web interface in the SkyNet style. Colours, font and
building blocks come from the [ShareOS](https://github.com/UniqueDroid/ShareOS) interface
(derived from the Skynet intranet): blue on near-black, monospace type, fine scan lines
and glowing accents.

![Preview of SkyNet (blue)](docs/preview-blue.png)

The preview images show a rebuild of the pfSense page structure, not a real firewall.

## Variants

| File | Theme name in pfSense | Accent |
|---|---|---|
| `css/SkyNet.css` | SkyNet | Blue (default) |
| `css/SkyNet-Green.css` | SkyNet-Green | Green |
| `css/SkyNet-Red.css` | SkyNet-Red | Red |
| `css/SkyNet-White.css` | SkyNet-White | White |

## Installation without SSH

In pfSense, open **Diagnostics → Command Prompt** and run this line under
*Execute Shell Command*:

```sh
fetch -qo - https://raw.githubusercontent.com/UniqueDroid/PfSense-Skynet-Theme/main/install.sh | sh
```

The script downloads the four CSS files to `/usr/local/www/css/` and changes nothing else.

Then select the theme: **System → General Setup → webConfigurator → Theme → SkyNet**, and save.

If you would rather not run a script from the network, download only the file you want:

```sh
fetch -o /usr/local/www/css/SkyNet.css https://raw.githubusercontent.com/UniqueDroid/PfSense-Skynet-Theme/main/css/SkyNet.css
```

If the firewall has no internet access: upload the CSS file in the same dialog under
*Upload File* (it lands in `/tmp`) and move it:

```sh
mv /tmp/SkyNet.css /usr/local/www/css/SkyNet.css
```

## Updating and removing

To update, run the installation line again, then reload the page with Ctrl+F5.

To remove:

```sh
fetch -qo - https://raw.githubusercontent.com/UniqueDroid/PfSense-Skynet-Theme/main/install.sh | sh -s -- uninstall
```

If a removed theme is still selected, pfSense shows its default theme again.

## Is it safe?

The theme is CSS only. It changes how the web interface looks and nothing about how the
firewall works: rules, routing, VPN, DNS and the configuration are not touched, and no
existing pfSense file is overwritten. The worst case is a page that looks wrong.

Ways back:

1. Select the theme *pfSense* again under System → General Setup.
2. Run `rm /usr/local/www/css/SkyNet*.css` under Diagnostics → Command Prompt. When the
   file is missing, pfSense uses its default theme.
3. If the web interface cannot be used at all, run the same `rm` command on the console
   (menu item 8, Shell).

## Good to know

- A pfSense update can remove custom files from `/usr/local/www/css/`. Run the installation
  line again; the theme selection is kept in the configuration.
- The login page has its own stylesheet and is not changed by themes
  (its colour: *System → General Setup → Login page color*).
- The font is JetBrains Mono if it is installed on your computer, otherwise the system's
  monospace font. Nothing is loaded from the internet.
- The theme builds on the firewall's own `pfSense.css` (`@import`) and only overrides
  colours, type and shapes. Layout and functions stay as they are.

## Customising

The files in `css/` are generated. The rules live in `src/base.css`, the colours of the
variants in `build.sh`:

```sh
sh build.sh
```

## License

GPL-2.0, see [LICENSE](LICENSE).
