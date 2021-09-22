// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © cvj0ven
//@version=4

study("BBMA", overlay=true)

//  BOLINGGER BAND

MidBB = sma(close, 20)
TopBB = MidBB + (2 * stdev(close, 20))
LowBB = MidBB - (2 * stdev(close, 20))

plot( MidBB, color=color.black, linewidth=1, style=plot.style_line, transp=0, title = "Mid BB")
plot( TopBB, color=color.black, linewidth=1, style=plot.style_line, transp=0, title = "Top BB")
plot( LowBB, color=color.black, linewidth=1, style=plot.style_line, transp=0, title = "Low BB")

// WMA 

wma5h  = wma(high, 5)
wma10h = wma(high,10)
wma5l  = wma(low , 5)
wma10l = wma(low ,10)

mahi5h  = plot(wma5h,  color=color.red,     linewidth=1, transp=90, title = "WMA 5H")
mahi10h = plot(wma10h, color=color.orange,  linewidth=1, transp=90, title = "WMA 10H")
malo5l  = plot(wma5l,  color=color.fuchsia, linewidth=1, transp=90, title = "WMA 5L")
malo10l = plot(wma10l, color=color.gray,    linewidth=1, transp=90, title = "WMA 10H")

ema50   = plot(ema(close,50), color=color.purple, linewidth=2, transp=10, title = "EMA 50")

// Fill WMA

fill(mahi5h,mahi10h, color= wma5h > wma10h ? color.gray  : color.red,  transp=70,  title = "Area High" )
fill(malo5l,malo10l, color= wma5l > wma10l ? color.green : color.gray, transp=70, title = "Area Low")




