// This source code is subject to the terms of the Mozilla Public License 2.0 at https://mozilla.org/MPL/2.0/
// © cvj0ven

//@version=4
study("FX_15min EMAs", overlay=true)

ema5 = ema(close, 5)
ema13 = ema(close, 13)
ema50 = ema(close, 50)
ema200 = ema(close,200)
ema800 = ema(close, 800)


plot(ema5, linewidth=1, color=color.new(color.aqua,30))
plot(ema13, linewidth=1, color=color.new(color.red, 30))
plot(ema50, linewidth=1, color=color.new(color.fuchsia, 30))
plot(ema200, linewidth=1, color=color.new(color.yellow, 30))
plot(ema800, linewidth=1, color=color.new(color.blue, 30))