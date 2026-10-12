# 🏆 GoldEdge Pro — Institutional Confluence & Trading Hub

A dedicated personal trading dashboard and confluence execution engine built specifically for **Gold (XAU/USD)** and Forex traders.

---

## 🚀 Key Features

1. **Institutional Confluence Radar:**
   * Dynamic, weighted scoring checklist (Key Levels, Century Numbers, Asian/PDH Liquidity Sweeps, Killzone Session Timings, HTF Trend, and Lower Timeframe confirmation).
   * Visual meter and real-time setup quality grading (**No Trade** vs. **Valid Setup** vs. **🔥 A+ Institutional Setup**).
   * **Real-time Audio & Visual Alerts:** Synthesizes institutional audio chimes using the HTML5 Web Audio API and triggers full-screen alert banners the second all confluences align.

2. **Position Size & Mathematical Outcome Calculator:**
   * Automatically calculates exact recommended **Lot Sizes** for Gold (100 oz per standard contract) and Forex pairs based on account balance and risk percentage.
   * Outputs exact Dollar Risk (`$`), Target 1 and Target 2 Dollar Returns (`$`), R-Multiples (e.g., `+3.5R`), and projected account balance post-trade.
   * One-click **"Record Directly into Trade Journal"** button.

3. **Trade Journal & Performance Analytics:**
   * Automatically tracks all trades with win/loss outcomes, lot sizes, confluences, entry, stop loss, and take profit.
   * Real-time KPIs: **Net Realized PnL**, **Win Rate %**, **Profit Factor**, and **High-Confluence Win Rate correlation**.
   * LocalStorage persistence (never loses data upon reload) + JSON export backup.

4. **TradingView Webhook Integration & Pine Script:**
   * Built-in `/api/webhook/tradingview` receiver format.
   * Copy-paste **Pine Script v5 Indicator** (`pine_script_alert.pine`) to automatically detect liquidity sweeps and round numbers directly on TradingView charts.
   * Instant browser push to **Telegram** or **Discord** via direct API integration.

---

## ⚡ How to Open and Use Immediately

### Method 1: Instant Browser Launch (Zero Setup)
Simply double-click or open `index.html` in your web browser (Google Chrome, Microsoft Edge, Brave):
```
C:\Users\amanu\.gemini\antigravity\scratch\gold_trading_hub\index.html
```
Everything runs locally in your browser with zero external installations!

---

### Method 2: Running the Webhook Server (For TradingView Webhook Alerts)
If you have Python installed and want to receive live webhook alerts from TradingView:
1. Open PowerShell in this folder:
   ```powershell
   python webhook_server.py
   ```
2. Open `http://localhost:8000` in your browser.
3. To route TradingView alerts from the web to your local PC, use free [ngrok](https://ngrok.com/):
   ```powershell
   ngrok http 8000
   ```
4. Copy the forwarding URL (e.g. `https://xxxx.ngrok-free.app/api/webhook/tradingview`) and paste it into your TradingView Alert "Webhook URL" field.

---

## 📁 File Structure

* [index.html](file:///C:/Users/amanu/.gemini/antigravity/scratch/gold_trading_hub/index.html) — Complete web application interface & logic.
* [pine_script_alert.pine](file:///C:/Users/amanu/.gemini/antigravity/scratch/gold_trading_hub/pine_script_alert.pine) — Ready-to-use Pine Script v5 indicator with webhook alerts.
* [webhook_server.py](file:///C:/Users/amanu/.gemini/antigravity/scratch/gold_trading_hub/webhook_server.py) — Lightweight webhook receiver server.
* [README.md](file:///C:/Users/amanu/.gemini/antigravity/scratch/gold_trading_hub/README.md) — Documentation and guide.
