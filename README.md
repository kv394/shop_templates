# Barber Shop Templates

A unified shop website template system where every HTML template uses the same shop ID workflow.

## 🎯 One Workflow for All Templates

You do not need separate instructions for each HTML theme.
Every template in this repository supports the same pattern:
- `{{SHOP_ID}}` is the only required placeholder
- `generate_theme.sh` can replace it automatically
- any template can be generated with the same command

### Quick Start
```bash
# Generate a site from any template
./generate_theme.sh <template-file.html> <your_shop_id> <output-file.html>
```

Example:
```bash
./generate_theme.sh simple-template.html my-shop-123 my-shop.html
./generate_theme.sh smartstyle-theme.html my-shop-123 my-smartstyle-site.html
```

### Manual Replacement
If you prefer not to use the script:
```bash
sed 's/{{SHOP_ID}}/your_shop_id/g' template-file.html > output-file.html
```

## 📁 Templates Included

- `simple-template.html` — clean, minimal dynamic shop template
- `smartstyle-theme.html` — SmartStyle-inspired visual theme with royalty-free hero imagery
- `sports-theme.html`, `luxury-theme.html`, `modern-dark.html`, `vintage-classic.html`, `clean-minimal.html`, `carte-blanche.html`, `neo-brutalism.html` — additional theme samples

## 🔧 Script

- `generate_theme.sh` — main generation script
  - simple mode: `./generate_theme.sh <template-file> <shop_id> <output-file>`
  - legacy mode: `./generate_theme.sh <template-file> <config-file> <output-file>`
- The script also injects the shared BarberSaaS SDK/init block into generated HTML when missing.

## 🎨 What happens automatically

The template will load shop data from BarberSaaS and apply:
- branding color from `shop.primaryColor`
- shop name and description
- services, products, and reviews
- booking integration

## 💡 Important Notes

- All modern templates use the same `{{SHOP_ID}}` placeholder
- You can generate any template with a single command
- `smartstyle-theme.html` already uses a royalty-free Pexels hero image
- Old config files are still available for advanced, manual theme customization

## 📌 Need to customize further?

Edit the template CSS variables in `:root` or update the HTML structure directly.
For theme-specific adjustments, change only the template file and reuse the same generation workflow.
