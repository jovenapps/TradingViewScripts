// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © cvj0ven

//@version=4
study("forzia", overlay=true)

// Basic moving averages
fast = ema(close,9)
slow = sma(close,20)
slow50 = sma(close,50)

plot(fast, color=color.green)
plot(slow, color=color.red)
plot(slow50, color=color.purple)

slow100 = sma(close,100)
// plot(slow100, color=color.blue)
 

isBullishMAs = fast > slow and slow > slow50
isBearishMAs = fast < slow and slow < slow50

// Bar or candle flags
isGreenBar = close > open
isRedBar = close < open
isThreeDayUp = close > close[1] and close[1] > close[2]
isThreeDayDown = close < close[1] and close[1] < close[2]
isFiveDayHigh = (close >= high[1] or high[0] >= high[1]) and (close > high[2] or high[0] > high[2]) and (close > high[3] or high[0] > high[3]) and close > high[4] and close > high[5]

// In case of a red bar, check if current bar low > prev low and current close > prev open.
// Also consider that prev bar is green and higher then next prev bar
bullishBar = isGreenBar
if (not isGreenBar)
    bullishBar := close > open[1] and low > low[1] and close[1] > open[1] and close[1] > close[2]

//MACD Settings
macdFast = input(title="MACD Fast moving average", type = input.integer, defval = 12, minval = 7)
macdSlow = input(title="MACD Slow moving average", type = input.integer, defval = 26, minval = 7)
signalLength = input(9,minval=1)

[currMacd,_,_] = macd(close[0], macdFast, macdSlow, signalLength)
[prevMacd,_,_] = macd(close[1], macdFast, macdSlow, signalLength)
signal = ema(currMacd, signalLength)

macdCrossoverBear = cross(currMacd, signal) and currMacd < signal ? avg(currMacd, signal) : na
macdCrossoverBull = cross(currMacd, signal) and currMacd > signal ? avg(currMacd, signal) : na

//RSI settings
RSIOverSold = input(29,minval=1)
RSIOverBought = input(71,minval=1)
src = close, len = input(14, minval=1, title="Length")
up = rma(max(change(src), 0), len)
down = rma(-min(change(src), 0), len)
rsi = down == 0 ? 100 : up == 0 ? 0 : 100 - (100 / (1 + up / down))
wasOversold = rsi[0] <= RSIOverSold or rsi[1] <= RSIOverSold or rsi[2] <= RSIOverSold or rsi[3] <= RSIOverSold or rsi[4] <= RSIOverSold or rsi[5] <= RSIOverSold
wasOverbought = rsi[0] >= RSIOverBought or rsi[1] >= RSIOverBought or rsi[2] >= RSIOverBought or rsi[3] >= RSIOverBought or rsi[4] >= RSIOverBought or rsi[5] >= RSIOverBought
rsiBullish50 = rsi[2] < 48 and rsi[1] < 48 and rsi[0] > 52 // Leaving the 48-50 as a range that must be jumped across
rsiBearish50 = rsi[2] > 51 and rsi[1] > 51 and rsi[0] < 50
rsiAlmostBullish50 = rsi[0] > 48 and rsi[0] < 55 // That small range near 50

// plotshape(crossoverBear, title='MACD-BEAR', style=shape.triangledown, text='overbought', location=location.abovebar, color=color.orange, textcolor=color.orange, size=size.tiny) 
// plotshape(crossoverBull, title='MACD-BULL', style=shape.triangleup, text='oversold', location=location.belowbar, color=color.lime, textcolor=color.lime, size=size.tiny) 

// A macd long entry has a crossover bull with the following:
//  RSI is oversold or below 30
//  RSI made a 50 cross and green bar
//  Price action made three bars up that caused the macd entry with rsi near 50
bullishPriceAction = (isFiveDayHigh or (isThreeDayUp and rsiAlmostBullish50))
longMACD = macdCrossoverBull and bullishBar and (wasOversold or rsiBullish50 or bullishPriceAction)
longColor = color.green
longText = 'buy'
if (wasOversold)
    longColor := color.green
    longText := 'oversold'
else if (rsiBullish50)
    longColor := color.lime
    longText := 'rsi bullish'
else if (bullishPriceAction)
    longColor := color.yellow
    if (isFiveDayHigh)
        longText := '5D high'
    else if (isThreeDayUp)
        longText := '3D Up'
    
// A macd short entry has a crossover bear with the following:
// RSI is overbought or over 70
// RSI made a 50 cross below with red bar
bearishPriceAction = (isThreeDayDown and isBearishMAs)
shortMACD = macdCrossoverBear and ((isRedBar and (wasOverbought or rsiBearish50)) or isBearishMAs) // or bearishPriceAction))
shortColor = color.orange
if (wasOverbought)
    shortColor := color.orange
else if (rsiBearish50)
    shortColor := color.fuchsia 
// else if (bearishPriceAction)
//     shortColor := color.red
    
plotshape(shortMACD, title='MACD-BEAR', style=shape.triangledown, location=location.abovebar, color=shortColor, textcolor=color.red, size=size.tiny) 
plotshape(longMACD, title='MACD-BULL', style=shape.triangleup, location=location.belowbar, color=longColor, textcolor=color.green, size=size.tiny) 



// strategy("test")
// if bar_index > 4000
//     strategy.entry("buy", strategy.long, 10, when=strategy.position_size <= 0)
//     strategy.entry("sell", strategy.short, 10, when=strategy.position_size > 0)
// plot(strategy.equity)
