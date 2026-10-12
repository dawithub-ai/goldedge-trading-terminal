//+------------------------------------------------------------------+
//|                                        Exness_Trade_Sync_MT5.mq5 |
//|                                    GoldEdge Pro Exness Connector |
//+------------------------------------------------------------------+
#property copyright "GoldEdge Pro"
#property link      "https://localhost:8000"
#property version   "1.00"
#property strict

// Inputs
input string InpFileName = "exness_goldedge_trades.json"; // Output Log File Name
input bool   InpSyncOnCloseOnly = true;                    // Record when trade closes

// Global Variables
datetime last_check = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   Print(">>> [GoldEdge Pro] Exness Trade Sync MT5 initialized successfully.");
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   Print(">>> [GoldEdge Pro] Exness Trade Sync MT5 removed.");
}

//+------------------------------------------------------------------+
//| Trade Transaction Event Handler                                 |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
{
   // When a deal is completed on Exness
   if(trans.type == TRADE_TRANSACTION_DEAL_ADD)
   {
      ulong deal_ticket = trans.deal;
      if(HistoryDealSelect(deal_ticket))
      {
         string symbol = HistoryDealGetString(deal_ticket, DEAL_SYMBOL);
         long deal_entry = HistoryDealGetInteger(deal_ticket, DEAL_ENTRY);
         
         // If a trade closed or opened
         if(!InpSyncOnCloseOnly || deal_entry == DEAL_ENTRY_OUT)
         {
            double profit = HistoryDealGetDouble(deal_ticket, DEAL_PROFIT);
            double volume = HistoryDealGetDouble(deal_ticket, DEAL_VOLUME);
            double price  = HistoryDealGetDouble(deal_ticket, DEAL_PRICE);
            long   type   = HistoryDealGetInteger(deal_ticket, DEAL_TYPE);
            string side   = (type == DEAL_TYPE_BUY) ? "BUY" : "SELL";

            PrintFormat("⚡ [Exness GoldEdge Sync] Ticket #%d | %s | %s | Lots: %.2f | Price: %.2f | Profit: $%.2f",
                        deal_ticket, symbol, side, volume, price, profit);
            
            // Append trade to local MQL5/Files JSON file
            int file_handle = FileOpen(InpFileName, FILE_READ|FILE_WRITE|FILE_TXT|FILE_ANSI);
            if(file_handle != INVALID_HANDLE)
            {
               FileSeek(file_handle, 0, SEEK_END);
               string log_entry = StringFormat("{\"ticket\":%d,\"symbol\":\"%s\",\"side\":\"%s\",\"lots\":%.2f,\"price\":%.2f,\"pnl\":%.2f,\"time\":\"%s\"}\n",
                                               deal_ticket, symbol, side, volume, price, profit, TimeToString(TimeCurrent()));
               FileWriteString(file_handle, log_entry);
               FileClose(file_handle);
            }
         }
      }
   }
}
