import requests
import sys
from datetime import datetime

def check_health(url):
    try:
        r = requests.get(url, timeout=5)
        print(f"[{datetime.now()}] {url} - {r.status_code}")
        return r.status_code == 200
    except Exception as e:
        print(f"[{datetime.now()}] {url} - FAILED: {e}")
        return False

if __name__ == "__main__":
    url = sys.argv[1] if len(sys.argv) > 1 else "http://nginx"
    sys.exit(0 if check_health(url) else 1)