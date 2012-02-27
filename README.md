# Getting Started
```
gw = Googleweather.new('Philadelphia')
```

## Current Weather

```
gw.now
```

## Forecast for specific day this week
Google only provides the next 4 days

```
gw.forecast[:sun] # :sun :mon :tues :wed :thu :fri :sat
```

weather = GoogleWeather.new("Philadelphia")
weather.now
weather.today
weather[:sunday]
weather[:monday]
weather[:tuesday]
weather[:wednesday]
weather[:now]
weather[:today]
weather[:friday]
weather[:saturday]
