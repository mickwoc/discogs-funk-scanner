import yaml

def load_config():
    with open("config.yml") as f:
        return yaml.safe_load(f)

config = load_config()
TOKEN = config["secrets"]["discogs_token"]

print("Scanner running with token:", TOKEN[:5] + "...")
print("⚠️ Full scanning logic connects here (Discogs API module)")
