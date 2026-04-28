#!/bin/bash

# Simple Shop Template Generator Script
# Usage: ./generate_theme.sh <template_file> <shop_id> <output_file>
# Or: ./generate_theme.sh <template_file> <config_file> <output_file> (legacy)

TEMPLATE_FILE=$1
SECOND_PARAM=$2
OUTPUT_FILE=$3

if [ -z "$TEMPLATE_FILE" ] || [ -z "$SECOND_PARAM" ] || [ -z "$OUTPUT_FILE" ]; then
    echo "Usage: $0 <template_file> <shop_id> <output_file>"
    echo "Simple: $0 simple-template.html your_shop_id output.html"
    echo "Legacy: $0 template.html config.txt output.html"
    exit 1
fi

insert_sdk_block() {
    if grep -q 'barbersaas-sdk.js?v=4' "$OUTPUT_FILE" && grep -q 'BarberSaaS.init' "$OUTPUT_FILE"; then
        return
    fi

    cat > "$OUTPUT_FILE.sdk" <<'EOF'
  <script>
    (function() {
      let domain = window.location.origin;
      let isFileProtocol = window.location.protocol === "file:";
      if (domain === "null" || domain === "about://" || window.location.protocol === "about:" || isFileProtocol) {
        try { domain = window.parent.location.origin; } catch(e) {}
      }
      if (domain === "null" || domain === "about://" || !domain) {
        domain = "https://barbersaas-henna.vercel.app";
      }

      const sdkScript = document.createElement("script");
      sdkScript.src = isFileProtocol && domain === "file://" ? "../barbersaas-sdk.js?v=4" : domain + "/barbersaas-sdk.js?v=4";
      document.head.appendChild(sdkScript);
    })();
  </script>
  <script>
    window.addEventListener("load", function() {
      function initializeShop() {
        if (typeof BarberSaaS === "undefined") return;

        const urlParams = new URLSearchParams(window.location.search);
        let shopId = urlParams.get("shopId");
        if (!shopId) {
          try { shopId = new URLSearchParams(window.parent.location.search).get("shopId"); } catch(e) {}
        }
        if (!shopId) {
          try { const parts = window.parent.location.pathname.split('/'); shopId = parts[parts.length - 1]; } catch(e) {}
        }
        shopId = shopId || "{{SHOP_ID}}";

        let domain = window.location.origin;
        let isFileProtocol = window.location.protocol === "file:";
        if (domain === "null" || domain === "about://" || window.location.protocol === "about:" || isFileProtocol) {
          try { domain = window.parent.location.origin; } catch(e) {}
        }
        if (domain === "null" || domain === "about://" || domain === "file://" || !domain) {
          domain = "https://barbersaas-henna.vercel.app";
        }

        const apiUrlToUse = (domain.includes("localhost") || domain.includes("127.0.0.1")) && !isFileProtocol ? domain : "https://barbersaas-henna.vercel.app";

        BarberSaaS.init(shopId, {
          position: "bottom-right",
          apiUrl: apiUrlToUse
        });
      }

      if (typeof BarberSaaS !== "undefined") initializeShop();
      else {
        let attempts = 0;
        const intv = setInterval(() => {
          attempts++;
          if (typeof BarberSaaS !== "undefined" || attempts >= 50) { clearInterval(intv); initializeShop(); }
        }, 100);
      }
    });
  </script>
EOF

    if grep -qi '</body>' "$OUTPUT_FILE"; then
      awk -v sdkfile="$OUTPUT_FILE.sdk" 'BEGIN { while ((getline line < sdkfile) > 0) { sdk = sdk line "\n" } close(sdkfile) }
        /<\/body>/ { printf "%s", sdk; print; next }1' "$OUTPUT_FILE" > "$OUTPUT_FILE.tmp"
      mv "$OUTPUT_FILE.tmp" "$OUTPUT_FILE"
    else
      cat "$OUTPUT_FILE.sdk" >> "$OUTPUT_FILE"
    fi

    rm -f "$OUTPUT_FILE.sdk"
}

# Check if second parameter is a file (legacy mode) or shop ID (simple mode)
if [ -f "$SECOND_PARAM" ]; then
    # Legacy mode: config file
    CONFIG_FILE=$SECOND_PARAM
    echo "Using legacy config file mode..."

    # Copy template to output
    cp "$TEMPLATE_FILE" "$OUTPUT_FILE"

    # Read config file and perform replacements
    while IFS='=' read -r key value; do
        # Skip comments and empty lines
        [[ $key =~ ^[[:space:]]*# ]] && continue
        [[ -z "$key" ]] && continue

        # Remove whitespace
        key=$(echo "$key" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        value=$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

        # Perform replacement - only replace exact placeholder matches
        if [ -n "$key" ] && [ -n "$value" ]; then
            # Escape ampersands in the value
            escaped_value=$(echo "$value" | sed 's/&/\\&/g')
            # Use ~ as delimiter
            sed -i "s~{{$key}}~$escaped_value~g" "$OUTPUT_FILE"
        fi
    done < "$CONFIG_FILE"
else
    # Simple mode: shop ID
    SHOP_ID=$SECOND_PARAM
    echo "Using simple shop ID mode..."

    # Copy template and replace SHOP_ID
    cp "$TEMPLATE_FILE" "$OUTPUT_FILE"
    sed -i "s/{{SHOP_ID}}/$SHOP_ID/g" "$OUTPUT_FILE"
fi

insert_sdk_block

if [ -n "$SHOP_ID" ]; then
    sed -i "s/{{SHOP_ID}}/$SHOP_ID/g" "$OUTPUT_FILE"
fi

echo "Shop site generated: $OUTPUT_FILE"