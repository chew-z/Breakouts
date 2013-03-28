//+------------------------------------------------------------------+
//|                                             Export_Matlab_01.mq4 |
//|                                            Copyright 2012 chew-z |
//| Dosyæ dojrza³a wersja - wymaga uwagi w linii poleceñ textscan( .)|
//| Mniej parametrów do eksportu                                     |
//+------------------------------------------------------------------+
#property copyright "Copyright 2012 by chew-z"
#property link      "Export_Matlab_03"
extern int minPeriod = 5;
extern int maxPeriod = 20;
extern int Shift = 1; // Przesuniêcie o dni przy liczeniu zmiennoœci ze StdDev
extern int EMA = 60;
extern int K = 3;     // filtr trendu
static int handle = 0;
static int lookBackDays = 5;
static double deltaVol = 0.0;
void init()  {
   handle = FileOpen(Symbol()+Period()+"_03.csv", FILE_CSV|FILE_WRITE);
}
void deinit()  {
   FileClose(handle);
}
int start() {
  int bars_count=Bars;
  int iDay = 1;
  int lookBackDays = 20;
  
  if(handle < 1)    {
     Print(" Export_Matlab_03: Problem z plikiem export.dat. Error ", GetLastError());
     return(false);
  } else    {
     FileWrite(handle, "#","DATETIME", "iDay","OPEN","HIGH","LOW", "CLOSE", "H", "L", "isTrend_L", "isTrend_H");
     for(int i=bars_count-1; i>=0; i--) {
       // 
       datetime t = Time[i];
         iDay = iBarShift(NULL, PERIOD_D1, Time[i],false) + 1; //Zamienia indeks bie¿¹cego baru na indeks dziennego Open (Z poprzedniego dnia!)
         lookBackDays = f_lookBackDays(iDay); //
       double  HH_D1 = iHigh(NULL, PERIOD_D1, iHighest(NULL,PERIOD_D1,MODE_HIGH,lookBackDays,iDay)); 
       double  LL_D1 = iLow(NULL, PERIOD_D1, iLowest(NULL,PERIOD_D1,MODE_LOW,lookBackDays,iDay));
       bool isTL = isTrending_L(iDay);
       bool isTS = isTrending_S(iDay);     
       //Numeracja wierszy jest wed³ug konwencji MQL czyli wstecz...      
       FileWrite(handle, i+1,t,iDay, Open[i],High[i], Low[i], Close[i], HH_D1, LL_D1, isTL, isTS );
       FileFlush(handle); // Flush every line?
     } // for(i=bars_count,...
     Print(" Export_Matlab_03 - Done: ", Bars);
  }
  return;
}

double f_lookBackDays(int iDay) {
double TodayVol, YestVol;

// Pierwszy wskaznik to aktualne StdDev
   TodayVol = iStdDev(NULL,PERIOD_D1,EMA,iDay,MODE_EMA,PRICE_CLOSE,0);
// Drugi wskaŸnik to StdDev cofniête o Shift dni (!!) niezale¿nie od timeframe wykresu   
   YestVol = iStdDev(NULL,PERIOD_D1,EMA,Shift+iDay,MODE_EMA,PRICE_CLOSE,0);
// A gdyby odwróciæ logikê? Gdy wiêksza zmiennoœæ na rynku to przebicie krótszych szczytów ma znaczenie?
      if(YestVol!=0)
      deltaVol = MathLog(TodayVol  / YestVol) ;        // Te poziomy to 1 Std dla EURUSD
      lookBackDays = maxPeriod / 2;
      if(deltaVol > 0.028)
         lookBackDays = maxPeriod;
      if(deltaVol < -0.028)
         lookBackDays = minPeriod;
      return(lookBackDays);
}
bool isTrending_L(int j) { // Czy œrednia szybka powy¿ej wolnej?
int i;
double M;
int sig = 0;
   for (i = K; i>-1; i--) {
      M = iMA(NULL,PERIOD_D1,maxPeriod,i,MODE_EMA,PRICE_CLOSE,iBarShift(NULL,PERIOD_D1,Time[j],false)+0);
      if (iMA(NULL,PERIOD_D1,minPeriod,i,MODE_EMA,PRICE_CLOSE,iBarShift(NULL,PERIOD_D1,Time[j],false)+0) > M)
         sig++;
   }
   if(sig < K)
      return(false);
   else 
      return(true);
}
bool isTrending_S(int j) { // Czy œrednia szybka poni¿ej wolnej?
int i;
double M;
int sig = 0;
   for (i = K; i>-1; i--) {
      M = iMA(NULL,PERIOD_D1,maxPeriod,i,MODE_EMA,PRICE_CLOSE,iBarShift(NULL,PERIOD_D1,Time[j],false)+0);
      if (iMA(NULL,PERIOD_D1,minPeriod,i,MODE_EMA,PRICE_CLOSE,iBarShift(NULL,PERIOD_D1,Time[j],false)+0) < M)
         sig++;
   }
   if(sig < K)
      return(false);
   else 
      return(true);
}

