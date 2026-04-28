# Shop Template Documentation

This documentation explains the shared workflow for all HTML templates in the repo.
Every template uses the same `{{SHOP_ID}}` replacement pattern and the same generation script.

## 🚀 One Command for Any Template

### Generate a shop website
```bash
./generate_theme.sh <template-file.html> <your_shop_id> <output-file.html>
```

Examples:
```bash
./generate_theme.sh simple-template.html my-shop-123 my-shop.html
./generate_theme.sh smartstyle-theme.html my-shop-123 smartstyle-shop.html
```

### Manual replacement
```bash
sed 's/{{SHOP_ID}}/your_shop_id/g' template-file.html > output-file.html
```

## 🧩 What this template system does

- keeps a single shared workflow across all page themes
- loads shop data from BarberSaaS
- applies reusable CSS theming via variables
- automatically updates shop name, description, services, products, and reviews
- lets you use any template with the same command

## ✅ Available templates

- `simple-template.html`
- `smartstyle-theme.html` (SmartStyle-inspired, royalty-free hero image)
- `sports-theme.html`
- `luxury-theme.html`
- `modern-dark.html`
- `vintage-classic.html`
- `clean-minimal.html`
- `carte-blanche.html`
- `neo-brutalism.html`

## 🛠️ Generation script

`generate_theme.sh` supports:
- simple mode: `./generate_theme.sh <template-file> <shop_id> <output-file>`
- legacy config mode: `./generate_theme.sh <template-file> <config-file> <output-file>`

The script also injects the shared BarberSaaS SDK/init block into generated HTML if the template does not already include it.

This means you can use the same script for every theme in the repository.

## 🧠 Consistent shop ID usage

Every template includes the same shop ID lookup logic:
```js
shopId = shopId || "{{SHOP_ID}}";
```

So once your `shop_id` is set, the same command works for every template.

## 🎨 SmartStyle theme note

`smartstyle-theme.html` is already configured with:
- royalty-free hero image from Pexels
- modern SmartStyle-inspired typography and layout
- dynamic shop branding via BarberSaaS

## 📌 When to use legacy config mode

Use legacy config mode only when you want to generate a custom theme from one of the config files:
```bash
./generate_theme.sh template.html sports_config.txt output.html
```

For normal use, you do not need these extra steps.

## 📎 Need to customize a template?

1. Pick the template HTML file.
2. Update the CSS or layout inside that file.
3. Generate with the same shop ID command.

This avoids repeated instructions per template and keeps the workflow clean.

## 🆘 Troubleshooting

- `SHOP_ID` not applying: ensure `{{SHOP_ID}}` remains in the template and run the script again.
- content missing: verify the shop has services/products/reviews configured in BarberSaaS.
- booking widget missing: confirm the SDK loads and the shop ID is valid.

---

This documentation is intentionally simple: change only the shop ID, then reuse the same generation step for every HTML theme in the repo.
```

## 🔧 Generation Script Usage

```bash
# Make script executable
chmod +x generate_theme.sh

# Generate theme
./generate_theme.sh template.html theme_config.txt output.html

# View result
open output.html
```

## 💡 AI Tips for Theme Creation

1. **Color Harmony**: Choose colors that work well together
2. **Typography Hierarchy**: Ensure text remains readable
3. **Brand Consistency**: Match colors and fonts to theme concept
4. **Mobile Responsiveness**: Test on different screen sizes
5. **Performance**: Use web-safe fonts and optimized images
6. **Accessibility**: Maintain good contrast ratios

## 🎨 Theme Inspiration

- **Bold & Energetic**: Sports, gaming, youth brands
- **Elegant & Sophisticated**: Luxury, spa, premium services
- **Warm & Inviting**: Cafes, restaurants, hospitality
- **Clean & Professional**: Corporate, medical, tech services
- **Fun & Playful**: Kids, entertainment, creative services
- **Natural & Calming**: Wellness, nature, health services

This template system gives AI complete creative control to generate unique, professional themes that perfectly match any brand personality or business type.

## Configuration Variables

### Basic Information
- `{{SHOP_TITLE}}` - The title that appears in the browser tab (e.g., "Sport Clips")
- `{{SHOP_TYPE}}` - The type of business (e.g., "Haircuts for Men")
- `{{SHOP_NAME_SHORT}}` - Short version of shop name for navbar (e.g., "SPORT CLIPS")
- `{{SHOP_NAME_FULL}}` - Full shop name for hero section (e.g., "Sport Clips Haircuts")
- `{{SHOP_TAGLINE}}` - Tagline under the shop name (e.g., "It's good to be a guy.")

### Colors
- `{{PRIMARY_COLOR}}` - Main brand color in hex format (e.g., "#E31837")

### Navigation
- `{{NAV_ABOUT}}` - Navigation link text for about section (e.g., "The MVP")
- `{{NAV_SERVICES}}` - Navigation link text for services (e.g., "Haircuts")
- `{{NAV_PRODUCTS}}` - Navigation link text for products (e.g., "Pro Gear")
- `{{NAV_REVIEWS}}` - Navigation link text for reviews (e.g., "Fan Highlights")
- `{{CTA_BUTTON}}` - Call-to-action button text (e.g., "Check In Now")

### Hero Section
- `{{HERO_BACKGROUND_URL}}` - URL for the hero background image
- `{{HERO_CTA}}` - Hero call-to-action button text (e.g., "Find a Service")

### Sections
- `{{SECTION_SERVICES}}` - Services section header (e.g., "Haircuts & Services")
- `{{SECTION_PRODUCTS}}` - Products section header (e.g., "Pro Gear")
- `{{SECTION_REVIEWS}}` - Reviews section header (e.g., "Fan Highlights")

### Loading Messages
- `{{LOADING_ABOUT}}` - Loading text for about section (e.g., "Loading Stats...")
- `{{LOADING_SERVICES}}` - Loading text for services (e.g., "Loading Playbook...")
- `{{LOADING_PRODUCTS}}` - Loading text for products (e.g., "Loading Gear...")
- `{{LOADING_REVIEWS}}` - Loading text for reviews (e.g., "Loading Highlights...")

### Buttons and Actions
- `{{BOOK_BUTTON}}` - Text for booking buttons (e.g., "Check In")
- `{{VIEW_BUTTON}}` - Text for view product buttons (e.g., "Details")
- `{{BUY_BUTTON}}` - Text for buy buttons (e.g., "Buy Now")
- `{{REVIEW_BUTTON}}` - Text for submit review button (e.g., "Submit Highlight")

### Default Content
- `{{DEFAULT_SERVICE_DESC}}` - Fallback description for services (e.g., "Professional haircut service.")
- `{{DEFAULT_PRODUCT_DESC}}` - Fallback description for products (e.g., "Premium grooming product.")
- `{{DEFAULT_REVIEW}}` - Fallback review text (e.g., "Great experience, highly recommend!")
- `{{REVIEW_SUCCESS}}` - Success message for review submission (e.g., "Highlight submitted!")

## Example Theme: Sports Theme

Replace the placeholders with these values to recreate the sports theme:

```
{{SHOP_TITLE}} = Sport Clips
{{SHOP_TYPE}} = Haircuts for Men
{{SHOP_NAME_SHORT}} = SPORT CLIPS
{{SHOP_NAME_FULL}} = Sport Clips Haircuts
{{SHOP_TAGLINE}} = It's good to be a guy.
{{PRIMARY_COLOR}} = #E31837
{{NAV_ABOUT}} = The MVP
{{NAV_SERVICES}} = Haircuts
{{NAV_PRODUCTS}} = Pro Gear
{{NAV_REVIEWS}} = Fan Highlights
{{CTA_BUTTON}} = Check In Now
{{HERO_BACKGROUND_URL}} = https://images.unsplash.com/photo-1599351431202-1e0f0137899a?auto=format&fit=crop&w=2000&q=80
{{HERO_CTA}} = Find a Service
{{SECTION_SERVICES}} = Haircuts & Services
{{SECTION_PRODUCTS}} = Pro Gear
{{SECTION_REVIEWS}} = Fan Highlights
{{LOADING_ABOUT}} = Loading Stats...
{{LOADING_SERVICES}} = Loading Playbook...
{{LOADING_PRODUCTS}} = Loading Gear...
{{LOADING_REVIEWS}} = Loading Highlights...
{{BOOK_BUTTON}} = Check In
{{VIEW_BUTTON}} = Details
{{BUY_BUTTON}} = Buy Now
{{REVIEW_BUTTON}} = Submit Highlight
{{DEFAULT_SERVICE_DESC}} = The MVP Experience.
{{DEFAULT_PRODUCT_DESC}} = Top-tier grooming gear.
{{DEFAULT_REVIEW}} = Great experience, highly recommend!
{{REVIEW_SUCCESS}} = Highlight submitted!
```

## Creating a New Theme

1. Copy the template to a new file
2. Choose a theme concept (e.g., "luxury", "vintage", "modern")
3. Select appropriate colors, terminology, and imagery
4. Replace all placeholders with theme-specific content
5. Test the template by opening it in a browser

## Tips for Creating Themes

- **Colors**: Choose 1-2 primary colors that match your theme
- **Language**: Use terminology that fits your theme (sports, luxury, vintage, etc.)
- **Imagery**: Select background images that reinforce your theme
- **Tone**: Adjust the loading messages and button text to match your brand voice
- **Consistency**: Make sure all elements work together cohesively

## Advanced Customization

- Modify the CSS for additional styling changes
- Add custom fonts or Google Fonts
- Adjust spacing, layout, or animations
- Add theme-specific icons or graphics
- Customize the JavaScript for additional functionality