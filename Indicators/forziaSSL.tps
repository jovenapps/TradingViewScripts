// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © cvj0ven

//@version=4
study("Forzia SSL", overlay=true)
ssl_period=input(title="SSL Period", defval=10)
show_50ma=input(title="Show 50ma", defval=true)

// SSL
smaHigh=sma(high, ssl_period)
smaLow=sma(low, ssl_period) 
int Hlv = na
Hlv := close > smaHigh ? 1 : close < smaLow ? -1 : Hlv[1]
sslDown = Hlv < 0 ? smaHigh: smaLow
sslUp   = Hlv < 0 ? smaLow : smaHigh

plot(sslDown, linewidth=1, color=color.new(color.red,30))
plot(sslUp, linewidth=1, color=color.new(color.lime,30))

// 50 ma
ma50 = sma(close, 50)
color50 = color.white
if(show_50ma == false)
    color50 := color.black
plot(ma50, linewidth=1, color=color.new(color50,30))



// Bollinger Band - Base Line
// bb_period = input(title="Bollinger ma", defval=50, minval=1)
// bb_src = input(close, title="Source")
// bb_mult = input(0.2, minval=0.001, maxval=50, title="StdDev")
// bb_basis = ema(bb_src, bb_period)
// bb_dev = bb_mult * stdev(bb_src, bb_period)
// bb_upper = bb_basis + bb_dev
// bb_lower = bb_basis - bb_dev
// bb_offset = input(0, "Offset", type = input.integer, minval = -500, maxval = 500)
// color bb_color = close > bb_basis ? color.new(#62E100,60) : color.new(#E19D00, 60)
// plot(bb_basis, "Basis", color.new(#A61E9D, 30), offset = bb_offset)
// bb_p1 = plot(bb_upper, "Upper", color=bb_color, offset = bb_offset)
// bb_p2 = plot(bb_lower, "Lower", color=bb_color, offset = bb_offset) 

// WAE
// sensitivity = input(150, title="Sensitivity")
// fastLength=input(20, title="FastEMA Length")
// slowLength=input(40, title="SlowEMA Length")
// channelLength=input(20, title="BB Channel Length")
// mult=input(2.0, title="BB Stdev Multiplier")

// DEAD_ZONE = nz(rma(tr(true),100)) * 3.7

// calc_macd(source, fastLength, slowLength) =>
//     fastMA = ema(source, fastLength)
//     slowMA = ema(source, slowLength)
//     fastMA - slowMA

// calc_BBUpper(source, length, mult) => 
//     basis = sma(source, length)
//     dev = mult * stdev(source, length)
//     basis + dev

// calc_BBLower(source, length, mult) => 
//     basis = sma(source, length)
//     dev = mult * stdev(source, length)
//     basis - dev

// t1 = (calc_macd(close, fastLength, slowLength) - calc_macd(close[1], fastLength, slowLength))*sensitivity
// t2 = (calc_macd(close[2], fastLength, slowLength) - calc_macd(close[3], fastLength, slowLength))*sensitivity

// e1 = (calc_BBUpper(close, channelLength, mult) - calc_BBLower(close, channelLength, mult))

// trendUp = (t1 >= 0) ? t1 : 0
// trendDown = (t1 < 0) ? (-1*t1) : 0

// plot(trendUp, style=plot.style_columns, linewidth=1, color=(trendUp<trendUp[1])?color.lime:color.green, transp=45, title="UpTrend")
// plot(trendDown, style=plot.style_columns, linewidth=1, color=(trendDown<trendDown[1])?color.orange:color.red, transp=45, title="DownTrend")
// plot(e1, style=plot.style_line, linewidth=2, color=#A0522D, title="ExplosionLine")
// plot(DEAD_ZONE, color=color.blue, linewidth=1, style=plot.style_cross, title="DeadZoneLine")

