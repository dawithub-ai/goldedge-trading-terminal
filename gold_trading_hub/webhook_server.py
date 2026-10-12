"""
GoldEdge Pro - Standalone Webhook Server
Zero external dependencies required (uses Python standard library).
Serves the web dashboard on http://localhost:8000 and receives TradingView alerts on /api/webhook/tradingview.
"""

import http.server
import socketserver
import json
import urllib.request
import os
import sys
from datetime import datetime

PORT = 8000
DIRECTORY = os.path.dirname(os.path.abspath(__file__))

class TradingHubHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def do_POST(self):
        # Handle incoming TradingView Webhooks
        if self.path == '/api/webhook/tradingview':
            content_length = int(self.headers.get('Content-Length', 0))
            post_data = self.rfile.read(content_length).decode('utf-8')
            
            try:
                payload = json.loads(post_data)
                symbol = payload.get('symbol', 'XAUUSD')
                action = payload.get('action', 'BUY')
                price = payload.get('price', 'N/A')
                confluences = payload.get('confluences', [])
                notes = payload.get('notes', '')

                now_str = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                print("\n" + "="*50)
                print(f"⚡ [TRADINGVIEW ALERT RECEIVED] at {now_str}")
                print(f"   Symbol:      {symbol}")
                print(f"   Action:      {action}")
                print(f"   Price:       ${price}")
                print(f"   Confluences: {', '.join(confluences)}")
                print(f"   Notes:       {notes}")
                print("="*50 + "\n")

                # Send success response
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.end_headers()
                response = json.dumps({"status": "received", "timestamp": now_str})
                self.wfile.write(response.encode('utf-8'))
            except Exception as e:
                print(f"[!] Error parsing webhook: {e}")
                self.send_response(400)
                self.end_headers()
        else:
            self.send_response(404)
            self.end_headers()

    def do_OPTIONS(self):
        # Support CORS for webhooks
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.end_headers()

if __name__ == '__main__':
    print(f"""
    ========================================================
     🏆 GoldEdge Pro - Trading Hub & Webhook Server
    ========================================================
     • Web Dashboard:  http://localhost:{PORT}
     • Webhook URL:    http://localhost:{PORT}/api/webhook/tradingview
    --------------------------------------------------------
     To expose to TradingView on the internet, run ngrok:
     > ngrok http {PORT}
    ========================================================
    Press Ctrl+C to stop.
    """)
    with socketserver.TCPServer(("", PORT), TradingHubHandler) as httpd:
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nShutting down server.")
            sys.exit(0)
