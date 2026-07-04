#!/bin/bash

set -e

echo "🎧 Installing Discogs Funk Scanner..."

# dependencies
if ! command -v python3 &> /dev/null
then
  echo "Python3 required."
  exit 1
fi

mkdir -p discogs-funk-scanner
cd discogs-funk-scanner

python3 -m venv venv
source venv/bin/activate

pip install --upgrade pip
pip install discogs-client pandas pyyaml openpyxl requests streamlit python-telegram-bot==13.15

mkdir -p data dashboard

echo "Enter Discogs token:"
read DISCOGS_TOKEN

echo "Enter Telegram bot token (optional):"
read TG_TOKEN

echo "Enter Telegram chat ID (optional):"
read TG_CHAT

cat > config.yml <<EOL
filters:
  styles: [Funk, Afrobeat]
  release_region: Africa

pricing:
  min_median_eur: 50
  max_discount_pct: 50

condition:
  allowed_media: [VG+, EX, NM, M]

market:
  seller_countries: [Germany, France, Belgium, Netherlands]

shipping:
  destination: IE
  rates:
    Germany: 8
    France: 10
    Belgium: 9
    Netherlands: 10

secrets:
  discogs_token: $DISCOGS_TOKEN
  telegram_token: $TG_TOKEN
  telegram_chat: $TG_CHAT
EOL

cat > run.sh <<EOL
#!/bin/bash
source venv/bin/activate
python main.py
EOL

chmod +x run.sh

echo "✅ Installed!"
echo "Run: cd discogs-funk-scanner && ./run.sh"
echo "Dashboard: streamlit run dashboard/app.py"
