// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © carl j0ven
//@version=4

//A simple display of multiple emas for viewing ema alignment and timing entries on the 9ema pullbacks.
study("scalp1m", overlay=true)

priceSetting = input(title="Price ema", type=input.integer, defval=9, minval=1)
smoothedSetting = input(title="Smoothed ema", type=input.integer, defval=20, minval=1)
baselineSetting = input(title="Baseline ema", type=input.integer, defval=50, minval=1)
trendSetting = input(title="Trend ema", type=input.integer, defval=100, minval=1)
longtrendSetting = input(title="Long Trend ema", type=input.integer, defval=200, minval=1)
volumeSetting = input(title="Volume ma", type=input.integer, defval=14, minval=1)

// Basic moving averages
m9 = ema(close,priceSetting)
m20 = ema(close,smoothedSetting)
m50 = ema(close,baselineSetting)
m100 = ema(close,trendSetting)
m200 = ema(close,longtrendSetting)

plot(m9, color=color.green)
plot(m20, color=color.red)
plot(m50, color=color.purple)
plot(m100, color=color.blue)
plot(m200, color=color.orange)
 

isBullishMAs = close > m9 and m9 > m20 and m20 > m50
isBearishMAs = close < m9 and m9 < m20 and m20 < m50

isBullCross = isBullishMAs and close[1] < m9 and close > high[1]
isBearCross = isBearishMAs and close[1] > m9 and close < low[1]

// Get volume
volumema = ema(volume, volumeSetting)
aboveAveVolume = volume > volumema
significantVolume = volume > (volume[1] * 1.5)

// If price has switched directions
prevBull = close[1] > open[1]
currentBull = close > open
volumeColor = (close > open) ? color.yellow : color.orange
if aboveAveVolume and not significantVolume
    if prevBull != currentBull
        significantVolume := true
        
hasVolume = aboveAveVolume and significantVolume

if volume > (volumema * 1.5)
    volumeColor := (close > open) ? color.lime : color.red

bullVolume = hasVolume and close > open
bearVolume = hasVolume and close < open

plotBullTriangle = isBullCross and hasVolume
plotBearTriangle = isBearCross and hasVolume


plotshape(plotBullTriangle, title='buy', style=shape.triangleup, location=location.belowbar, color=color.green, textcolor=color.green, size=size.small) 
plotshape(plotBearTriangle, title='sell', style=shape.triangledown, location=location.abovebar, color=color.red, textcolor=color.red, size=size.small) 

// plotshape(bullVolume, title='vol', style=shape.cross, location=location.belowbar, color=volumeColor, textcolor=volumeColor, size=size.tiny) 
// plotshape(bearVolume, title='vol', style=shape.cross, location=location.abovebar, color=volumeColor, textcolor=volumeColor, size=size.tiny) 


