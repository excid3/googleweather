# Getting Started
gw = Googleweather.new('Philadelphia')

## Current Weather
gw.weather.now

## Forecast for specific day this week
Google only provides the next 4 days
gw.weather.forecast[:sun]

Will update this soon.
