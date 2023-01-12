//
//  ToDoView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 19/10/2022.
//

import SwiftUI

var toDo_1 =
"""
i O S :

"""

var toDo_2 =
"""
    1. 🟢 Velges morgendagen i "DAG OVERSIKT" vises dagens dato i DayDetail().
    2. 🟢 Øke høyden på DayDetail().
    3. 🟢 DayOverview() :
            🟢 Legge inn min temperatur som heter "highTemperature" i DayWeather (dailyForecast).
            🟢 Legge inn max temperatur som heter "lowTemperature" i DayWeather (dailyForecast).
            🟢 Sannsynlighet for regn under iconet som heter "precipitationChance" i DayWeather (dailyForecast).
            🟢 Sjekk om nedbørsmengden er "rainfallAmount" eller "snowfallAmount" fra DayWeather (dailyForecast).
    4. 🟢 WeatherForecastDetail() : Legg inn min og max temperaturen.
    5. 🟢 WeatherForecast() : Legg inn Refresh som først setter weather = nil.
    6. 🟢 RainLast24h() : Legg inn regn i læpet av:
           🟢 De forrige 24 timene
           🟢 De neste 24 timene
           🟢 Må finne en offset for å kompensere for tidsforskjell mellom Date() og local dato
    7. 🟢 AirPressure() :
            🟢 Bygge om til Gauge() med .gaugeStyle(.accessoryCircular).
    8. 🟢 FeelsLike() :
           🟢 Ved "føles som" == "temperatur", legg inn "Samme som faktisk temperatur."
    9. 🟢 @EnvironmentObject var currentWeather: CurrentWeather
           🟢 Implementere CurrentWeather (søk med weather.cur) :
              🟢 SunMarkHourNow().
              🟢 AirPressure().
              🟢 FeelsLike().
              🟢 Humidity().
   10. 🟢 Ved endring av menyen må dataene oppdateres.
           🟢 Har lagt inn: .onChange(of: option) { option in
   11. 🟢 DayDetailDayDataView()
            🟢 Vise dagens høyeste temperatur : array.max()
            🟢 Vise dagens laveste temperatur : array.min()
   12. 🟢 UvIndex():
           🟢 Bytte til Gauge med .gaugeStyle(.accessoryLinear).
           🟢 UvIndexRestOfDay(): Legg inn .minimumScaleFactor(0.75)
   13. 🟢 AirPressure():
           🟢 Justere linjene.
   14. 🟢 Sun():
           🟢 Justere linjene.
           🟢 Bytt til class SunInfo: ObservableObject for å ta vare på soloppgang /solnedgang.
           🟢 Markere tid på dagen med .orange om dagen og .secondary om natten.
   15. 🟢 DayDetail() :
           🟢 Marker min og maks temperaturen pr. index.
   16. 🔴 DayDetailDayDataView():
           🟢 Finn data ved endring i menyen.
           🟢 Finn data ved endring av index.
           🟢 Lage "iconArray".
           🟢 Finn riktig "systemname" til temperatur de neste dagene ut fra "iconArray".
           🟢 DayDetailChart() : juster "curGradient".
           🟢 FindDataFromMenu() :
               🟢 dayArray: endre "sikt" fra meter til kilometer.
               🟢dayArray: endre "luftfuktighet" fra 0 til 100 %.
           🟢 DayDetailChart() :
               🟢 justere beregnet index ut fra .option
               🟢 justere linen fra...til OK for iPad
           🟢 DayDetailChart() :
               🟢 Vise Chart med LineMark og AreaMark ut fra menyvalget.
                   🟢 Temperatur.
                   🟢 Vind.
                   🟢 Føles som.
                   🟢 Luftfuktighet.
                   🟢 Sikt.
                   🟢 Lufttrykk.
              🟢 Vise enhetene ut fra .option
              🟢 Vise enhetene ut fra .option på y aksen.
              🟢 Markere den tidligere delen av døgnet på Chart().
                  🟢 Kun på dagen idag.
              🟢 Vise Chart med BarMark for:
                  🟢 Nedbør.
                  🟢 Ikke bare vise Regn (egen farge med markering)
                     🟢 Hail   hagl      (egen farge med markering)
                     🟢 Mixed  blandet   (egen farge med markering)
                     🟢 Sleet  sludd     (egen farge med markering)
                     🟢 Snow   Snø       (egen farge med markering)
              🟢 Merkere verdien på LineMark ved Gesture.
              🟢 Legge inn iconer som heading.
              🟢 RectangleMark():
                 🟢 Legg inn RectangleMark()
                 🟢 Finn xTil som er == currentWeather.hour
              🟢 DayDetailChart():
                  🟢 Legg inn iconer som heading.
                      🟢 Vurder å vise kun 12 stk.
                  🟢 Sett PointMark ut fra tidspunkt på dagen.
              🟢 Rettet: Hvorfor vises ikke iconene på BarChart?.
              🟢 BarChart:
                  🟢 Rettet : Piler frem og bakover skjules i iPhone.
                  🟢 Sjekk verdiene Nedbør ved å gå forbi siste verdi.
                  🟢 Rettet: Pilene frem og tilbake oppdaterer ikke minMaxArray.
                  🟢 chartForegroundStyleScale() : Endre fargerekkefølge: regn = cyan, sludd = blå, snø = hvit osv.
              🟢 SunDayAndNight():
                  🟢 Json fra Met.no på soloppgang og solnedgang.
                  🟢 Legg inn visning pr. index, ikke bare dagens dato.
              🟢 WindDirection()
                  🟢 Øke oppløsning på vindretningen f.nnø nordnordøst NNØ.
              🟢 SettingView() og UserSettings():
                  🟢 Legg inn Met.no parametre : https://api.met.no/weatherapi/sunrise/2.0/.json?
              🟢 WeatherForecast() :
                  🟢 Finn local offset fra UTC (hardkodet = +01:00
              🟢 Erstatte ActivityIndicator() med ProgressView()
              🟢 Ta bort: print(tempIconArray as Any)
              🟢 Ny: func UvIndexDescription(uvIndex: Int) -> String
              🟢 Oppdatere DayDetailWeatherData() sine sub-apper med aktuelle data:
                  🟢 DayDetailWeatherDataTemperature()
                  🟢 DayDetailWeatherDataUvIndex()
                  🟢 DayDetailWeatherDataWind()
                  🟢 DayDetailWeatherDataPrecification()
                     🟢 Legg inn snøvarsel.
                  🟢 DayDetailWeatherDataFeelsLike()
                  🟢 DayDetailWeatherDataHumidity()
                  🟢 DayDetailWeatherDataVisibility()
                  🟢 DayDetailWeatherDataAirPressure()
              🟢 Disse iconene endrer seg ikke ved bytte av index:
                  🟢 Vind
                     🟢 få med index = 0
                  🟢 Luftfuktighet
                     🟢 få med index = 0
                  🟢 Sikt
                     🟢 få med index = 0
                  🟢 Lufttrykk
                     🟢 få med index = 0
              🟢 DayDetailChart()
                  🟢 Vise både vind og vindkast.
                  🟢 Vise både temperatur og følt temperatur.
                  🟢 DayDetailHourIcons() legg inn option for menyvalget:
                        🟢 Uv-index som bruker verdiene hver 2. time
                        🟢 Vind som bruker vindpiler                       
                        🟢 Luftfuktighet som deler døgnet opp i 12 prosenter
                        🟢 Sikt 12 x km (34 30 35 34 30 35 34 30 35 34 30 35)
                        🟢 Lufttrykk 12 icons (stigende, fallende eller stabilt)
                  🟢 Vise generelle og værspesifikke tekster:
                     🟢 Generell informasjon.
                     🟢 Værspesifikk informasjon.
                  🟢 Endre Y - verdien : (ViewModifier DayDetailChartYaxis(option: option):
                     🟢 .uvIndex
                     🟢 .airPressure.
                  🟢 PointMark(x: .value("Index", 12),  y: .value("Amount", 10)) med min og max verdi:
                      🟢 Temperatur
                      🟢 UV-indeks
                      🟢 Vind
                      🟢 BarMark:
                         🟢 Høyeste verdi markeres med 'H' dersom det kommer flere
                            påfølgende verdier som samme verdi som ved MaxIndex.
                            Løsning:
                            Fra: MaxIndex = array.firstIndex(of: array.max()!)!
                            Til: MaxIndex = array.lastIndex(of: array.max()!)!
                         🟢 Det ser ut som det er en feil i .annotation for BarMark.
                            Kan ikke ha logikk på idx == MaxIndex og MinIndex
                      🟢 Føles som
                      🟢 Luftfuktighet
                      🟢 Sikt
                      🟢 Lufttrykk
              🔴 Vurdere om å legge inn snøvarsel i løpet av periden på alle menyvalg
              🔴 DayDetail() sin hideDayDetailMenuDataView styrer nå om
                     selectedValue skal vises i DayDetailMenuDataView().
                     Må nok omarbeides noe. Sjekk .gesture i DayDetailChart()
                     som oppdaterer @State private var show.
              🔴 Rain24h() bruker hardkodet CLLocation(latitude: 58.618050, longitude: 5.655520)
                  🔴 LocationManager()
                  🔴 InfoPrecipitation()
                  🔴 DayDetailWeatherDataPrecifitation()
                  🔴 Precipitation24h()
                  🔴 Precipitation24hFind()
                  🔴 PrecipitationFindRestOfDay()
                  🔴 WeatherForecast()
                  🔴 WeatherForecastDetail()
   17. 🔴 Legge inn valg på andre steder.....
   18. 🔴

"""

var toDo_3 =
"""
F e r d i g

"""

var toDo_4 =
"""
    1. 🟢 Nå vises datoen fra "DAG OVERSIKT" i DayDetail().
    2. 🟢 Økt høyden på DayDetail() fra 500 til 550.
    3. 🟢 DayOverview() :
            🟢 Lagt inn "highTemperature".
            🟢 Lagt inn "lowTemperature".
            🟢 Lagt inn "precipitationChance"
            🟢 Lagt inn nedbør både som regn og snø.
    4.  🟢 WeatherForecastDetail() : Lagt inn høy og lav temperatur.
    5.  🟢 WeatherForecast() : Lagt inn Refresh som først setter weather = nil.
    6.  🟢 RainLast24h() : Har lagt inn regn i løpet av:
            🟢 De forrige 24 timene
            🟢 De neste 24 timene
            🟢 Lagt inn func hoursFromGMT() (WeatherKit gir alltid datoene i UTC) :
                . som gir : 2 (lokal tid Norge) ved Central European Summer Time (CEST) = UTC +2
                . som gir : 1 (lokal tid Norge) ved Central European Time (CET) = UTC +1
    7. 🟢 AirPressure() :
            🟢 Bygd om til Gauge() med .gaugeStyle(.accessoryCircular).
    8.  🟢 FeelsLike() :
            🟢 Lagt inn: "Samme som faktisk temperatur."
    9.  🟢 @EnvironmentObject var currentWeather: CurrentWeather
           🟢 Implementere CurrentWeather (søk med weather.cur) :
              🟢 SunMarkHourNow().
              🟢 AirPressure().
              🟢 FeelsLike().
              🟢 Humidity().
   10. 🟢 Ved endring av menyen må dataene oppdateres.
           🟢 Har lagt inn: .onChange(of: option) { option in
   11. 🟢 DayDetailDayDataView()
            🟢 Vise dagens høyeste temperatur : array.max()
            🟢 Vise dagens laveste temperatur : array.min()
   12. 🟢 UvIndex():
           🟢 Byttet til Gauge med .gaugeStyle(.accessoryLinear).
           🟢 UvIndexRestOfDay(): Lagt inn .minimumScaleFactor(0.75)
   13. 🟢 AirPressure():
           🟢 Justert linjene.
   14. 🟢 Sun():
           🟢 Justert linjene.
           🟢 Byttet til class SunInfo: ObservableObject for å ta vare på soloppgang /solnedgang.
           🟢 Markerer tid på dagen med .orange om dagen og .secondary om natten.
   15. 🟢 DayDetail() :
           🟢 Markerer min og maks temperaturen pr. index.
   16. 🔴 .

"""

struct ToDoView: View {
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    Text(String(localized: "toDo"))
                        .font(.largeTitle)
                    Spacer()
                }
                Text(toDo_1)
                    .foregroundColor(.red)
                Text(toDo_2)
                    .multilineTextAlignment(.leading)
                Text(toDo_3)
                    .foregroundColor(.green)
                Text(toDo_4)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.leading, 10)
        }
    }
}

