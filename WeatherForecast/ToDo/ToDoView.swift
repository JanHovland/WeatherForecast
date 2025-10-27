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
   16. 🟢 DayDetailDayDataView():
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
              🟢 Lage lantitude og longitude som globale optional variable = Double?
                  🟢 LocationManager()
                  🟢 InfoPrecipitation()
                  🟢 DayDetailWeatherDataPrecifitation()
                  🟢 Precipitation24h()
                  🟢 Precipitation24hFind()
                  🟢 PrecipitationFindRestOfDay()
                  🟢 WeatherForecast()
                  🟢 WeatherForecastDetail()
              🟢 SelectedValue vises nå tilnærmet bra (finjustering gjenstår)
   17. 🟢 Nye funksjoner i CloudKit:
          🟢 FindAllPlaces()
          🟢 DeleteOnePlace()
          🟢 SaveNewPlace()
   18.  🟢 WeatherSelectPlace()
             🟢 Kalles opp slik:
             🟢 WeatherSelectPlace() som en tab i iPhone.
             🟢 WeatherSelectPlace() som en tab i iPad.
             🟢 iPhone: Få med .navigationBarTitle(Text(String(localized: "Weather overview"))):
                🟢 Lage en viewModifier som kun har NavigationView når UIDevice == iPad.
             🟢 Legg inn :
                🟢 FindAllPlaces()
                🟢 RefreshAllPlaces()
                🟢 DeleteOnePlace()
                   🟢 Legg inn func : DeleteOnePlace()
                   🟢 Legg inn icon. (i dag vises kun "Slett")
                      ☠️ Ser ut som .labelStyle(.titleAndIcon) ikke virker på Label
                         i .swipeActions (Feil??)
                🟢 Legge inn søkefelt.
                🟢 SaveNewPlace()
                   🟢 Finne latitude og longitude før SaveNewPlace()
                      🟢 Sette limit=1 på OpenCage
                🟢 Endre oversikten av valgte steder.
             🟢 Kalle opp WeatherForecast() fra WeatherSelectPlace.
   19. 🟢 WeatherForecast() :
          🟢 Legg inn meny:
             🟢 Frisk opp
                🟢 Bør også friske opp "localized" sted.
             🟢 Frisk opp offset
             🟢 Informasjon
          🟢 Sjekk om internet er tilgjengelig.
          🟢 Sjekk om alle innstillingene er lagt inn.
   20. 🟢  Sjekk round() og erstatt round() med .rounded()
           🟢 Feelslike():
           🟢 WeatherForecastDetail()
           🟢 HourOverview()
           🟢 Humidity()
           🟢 Visibility()
   21. 🟢 WeatherForecastSelectPlace() :
           🟢 Mangler data på index == 0 (ok på resten av indeksene?)
              🟢 Dette skyldes at "DateSettings" må settes til søkte sted.
           🟢 Søker på New York De forente Stater:
              🟢 Søking med selection.title + " " + selection.subtitle (New York De forente Stater) gir ikke noe resultat
              🟢 Søking med kun selection.title (New York) gir OK
   22. 🟢 Sjekk soloppgang og solnedgang fra Metno.no for New York (kun lokal tidszone ???)
          🟢 AdjustOffset coverterer "-0500" til "-05:00"
                 currentWeather.temperature med: weather!.currentWeather.temperature.value
   23. 🟢 Splitte func refresh() async opp i:
          🟢Ny func: Finne latitude, longitude og georecord.place
          🟢 Ny func: Finne soloppgang og solnedgang
          🟢 Problemer: Ny func: Finne weather og oppdatere currentWeather
             🟢 Gå tilbake til originalen
   24. 🟢 HourOverview():
          🟢 Rettet: Data vises nå korrekt.
   25. 🟢 DayOverview():
          🟢 Rettet: Data vises nå korrekt.
   26. 🟢 Flere steder har ikke 24 elementer på index 0
          🟢 Rettet ved å lage global hourForecast og bruke den på FindDataFromMenu()
   27. 🟢 HourOverview():
          🟢 Har lagt inn soloppgang og solnedgang på "Timesoversikt...."
   28. 🟢 DayDetailBackground() viewModifier:
           🟢 Lagt inn 'weather.currentWeather.isDaylight'
   29. 🟢 Må forbedre søket for OpenCage :
          🟢 WeatherForecastSelectPlace():
              🟢 Må lage ny søk med :
                 🟢 By searchbar.
              🟢 Kommer det opp flere steder:
                 🟢 Vise stedene.
                 🟢 Velge og lagre valgt sted.
                    🟢 Varsel om stedet finnes fra før.
   30. 🟢 SunRiseOrSet() i HourOverview():
          🟢 Rettet: Feil ved Beijing linje 22:  let sTime = sunTime[idx] idx = 74.
             Kan ikke trekke to datoer fra hverandre bruk: DaysBetween().
   31. 🟢 DayDetailChart():
          🟢 Annotation "H" på "nedbør" er nå korrekt.
             🟢 Det viser seg at en må benytte:
                precipitationMaxIndex = array.lastIndex(of: array.max()!)!
                Eller vil ikke "H" alltid komme frem!
   32. 🟢 Gi melding dersom:
          🟢 weather er nil
          🟢 hourForecast er nil
   33. 🟢 Uoverensstemmelse for dataoene for 'Beijing' +0800
          🟢 Rettet.
   34. 🟢 Legg inn tilleggsmelding:
          🟢 "Avslutt appen."
   35. 🟢 Legge inn: Nå er det lørdag 4. mars på:
          🟢 Temperatur (mangler . etter 4)
          🟢 UV-indeks
          🟢 Vind
          🟢 Nedbør
          🟢 Føles som
          🟢 Luftfuktighet
          🟢 Sikt
          🟢 Lufttrykk
   36. 🟢 WeatherForecastSelectPlace:
          🟢 Har laget oppdate pga. eventuell sommertid når en henter fra "Mine steder"
   37. 🟢 WeatherForecastSelectPlace():
          🟢 Viser nå aktuelle værdata på "Mine steder".
          🟢 Viser nå "klokken" på "Mine steder".
   38 🟢 WeatherForecast():
          🟢 Lage et view for informasjon.
   39. 🟢 WeatherForecastSelectPlace():
          🟢 Vise "lokal sted" øverst på listen.
   40. 🟢 WeatherForecast():
          🟢 Vise land.
   41. 🟢 WeatherForecast():
          🟢 Lagt inn menypunkt med:
             🟢 func RefreshOffset() som modifiser offsetSec og offsetString
          🟢 Legge inn et nytt menu punkt 'Lagre lokalt sted'
   42. 🟢 WeatherForecastSelectPlace():
          🟢 Tok bort "refreshable" for å få WeatherForecast() OK.
          🟢 Legg inn fast Søkefelt.
          🟢 Legg inn overskrift "Været".
          🟢 Funksjon TransLateCountry():
             🟢 Oversett f.eks. Norway til Norge
          🟢 Tilpasse sheet for iPad:
             🟢 Bruker .fullScreenCover som et kompromiss fordi det ikke er mulig å endre bredden, kun høyden.
             🟢 Lagt inn et 4.menypunkt: "Avslutt full screen".
                Dette 4. kommer frem ved kallet: .fullScreenCover
   43. 🟢 WeatherForecastSelectPlace():
          🟢 Legg inn meny helt til høyre for headingen "Været" :
             🟢 Flytte menu punkt func RefreshOffset() som modifiser
                offsetSec og offsetString fra WeatherForecast()
             🟢 Nytt punkt oppfriskningg virker nå, men må være tolmodig.
   44. 🟢 SettingView() og UserSettings():
          🟢 Legg inn en setting om valg av visning av værdata på
             på alle stedene i WeatherForecastSelectPlace().
             🟢 RefreshAllPlaces(refreshWeather: false):
                Erstatte "false" med en setting.
                🟢 "Always show weather on places in CloudKit"
   45. 🟢 InfoUvIndex():
          🟢 Rettet visningen.
   46. 🟢 DayDetail() viser søndag på 2 datoer 26 og 27:
          🟢 Dette er nå rettet.
          🟣 Sjekk nøye om det kommer nye feil!
             (DayDetail() linje 589 showAlert.toggle() er kommentert bort.
   47. 🟢 Har lagt inn DtTimeInterval() som info der REST bruker dt (sekunder siden 1970) som tid
   48. 🟢 WeatherForecastSelectCardView()
          🟢 Sjekk fonter for iPhone.
          🟢 Legg inn "Min posisjon" på lokal posisjon.
          🟢 Sjekk lagring av "Min posisjon".
   49. 🟢 WeatherForecastSelectPlace()
          🟢 Bergen: Rettet: Feil med lagring av offsetSec og offsetString
          🟢 Meny: "Frisk opp offset" -> Rettet: Feil med oppdatering av offsetSec og offsetString
          🟢 Rettet: Datoene vises nå korrekt for de enkelte stedene.
   50. 🟢 DayDetail()
          🟢 Linje 179: Justere ukedagene og datoene.
   51. 🟢 Sun()
          🟢 Justere bredden på visningen av SunDayAndNight().
   52. 🟢 DayDetail()
   53. 🟢 InfoTemperature()
          🟢 Rettet klokkeslett til temperaturer for index > 0
   54. 🟢 DayDetailChart():
          🟢 Legg inn synlig linje ved visning av verdier.
             🟢 Tilpasse visningen og posisjoneringen til valgt chart.
                🟢 Temperatur:     selectedValue + icon + klokkeslett (center)
                🟢 UV-indeks:      selectedValue + text + klokkeslett (center)
                🟢 Vind:           selectedValue + øsø (vindretning) + klokkeslett (center)
                🟢 Nedbør:         selectedValue + klokkeslett (center)
                🟢 Føles som:      selectedValue + klokkeslett (center)
                🟢 Luftfuktighet:  selectedValue + "Duggpunktet = xº" + klokkeslett (center)
                   🟢 Finner nå dewPointArray
                   🟢 Litt justering på posisjonen
                🟢 Sikt:           selectedValue + km + klokkeslett (center)
                🟢 Lufttrykk:      selectedValue + hPa + klokkeslett (center)
   55. 🟢 Legge inn bedre melding dersom weather / forecast er nil
   56. 🟢 Tatt bort pil høyre/venstre og erstatt dem med sveip høyre/venstre.
   57. 🟢 DayDetail() linje 250
          🟢 Viser nå riktig tidspunkt.
   58. 🟢 Vise animert vær i en periode.
          🟢 https://api.met.no/weatherapi/geosatellite/1.4/documentation
          🟢 https://api.met.no/weatherapi/geosatellite/1.4/europe.mp4
          🟢 Må ikke tilpasse iPhone noe.
   59. 🟢 Rettet "dismissAlert(seconds: 4)" på RefreshOffset()
          🟢 Tatt bort exit(0).
   60. 🟢 DayDetailWeatherDataTemperature()
          🟢 Må oppdatere dataArray fra FindDataFromMenu.
   61. 🟢 FindCurrentLocation() ??????
          🟢 lowTemperature = weather.dailyForecast.forecast[0].lowTemperature.value
          🟢 highTemperature =  weather.dailyForecast.forecast[0].highTemperature.value
   62. 🟢 onChange(of:perform):
          Må legge inn både gammel og ny verdi.
   63. 🟢 Sjekk posisjon av solen i Beijing (viser om dagen når det skal være om natten)
   64. 🟢 Sjekke nøye "@Environment(DateSettings.self) private var dateSettings"
   65. 🟢 Chart "Luftfuktighet" viser nå verdier når "luftfuktighet" velges.
   66. 🟢 Chart "Sikt" viser nå verdier når "sikt" velges.
   67. 🟢 Visningsverdiene må vises fullstendig både til venstre og høyre
   68. 🟢 Nytt View for oppstart som inneholder alle valgte stedene.
   69. 🟢 Menyen:
          🟢 Legge inn "Oppdater tidssoner".
          🟢 Legge inn "Søkefelt".
          🟢 "Oppfrisking av stedene mine".
   70. 🟢 Slette et av "Mine steder" etter å ha valgt stedet.
   71. 🟢 Luft kvalitet finnes her:  OpenWeather Air Pollution API
          🟢 Lage modellen via Quicktime
          🟢 Legg inn key i Settings
          🟢 Finne verdiene fra https://
          🟢 Lage AirQualityView()
   72. 🟢 Endre Temperatur til "Værforhold"
          🟢 Værforbehold
   73. 🟢 Gå gjennom heading og gesture visning på Chart
          🟢 Værforbehold
          🟢 UV-index
          🟢 Vind
          🟢 Nedbør
          🟢 Føles som
          🟢 Luftfuktighet
          🟢 Sikt
          🟢 Lufttrykk
   74. 🟢 Rettet "Sikt" som viser 0 til 0 km
   75. 🟢 Ta bort scroll indicator
   76. 🟢 Hindre ScrollView i å overse safe area
          🟢 DayDetail() .padding(.top, 0.2) linje 324
   76. 🟢 Nye tilpasninger for Chart (nå er det munig å scrolle Info...)
          🟢 Dette må legges inn i:
             🟢 Værforbehold
             🟢 UV-index
             🟢 Vind
             🟢 Nedbør
             🟢 Føles som
             🟢 Luftfuktighet
             🟢 Sikt
             🟢 Lufttrykk
   77. 🟢 Chart uvIndex for iPad mangler visning hittil i dag
   78. 🟢 Nye verdier inn under Chart:
             - Sannsynlighet for nedbør
             - Total nedbørsmengde
             - Siste 24 timer
             - Neste 24 timer
             - Dagsforskjeller
             🟢 Dette må legges inn i:
                  🟢 Værforbehold
                  🟢 UV-index
                  🟢 Vind
                  🟢 Nedbør
                  🟢 Føles som
                  🟢 Luftfuktighet
                  🟢 Sikt
                  🟢 Lufttrykk
   79. 🟢 Tilpasse meny oppe til venstre
          🟢 Legg inn "Tap for info" og image "info.square"
   80. 🟢 Bruk ▼ og ▲ for å vise "collapsable" forurensinger.
   81. 🟢 Avslutte appen når ved manglende data fra Internett API's
          🟢 Ny func  DismissAlertAndExitApp(seconds: Double, alert:  inout Bool)
   82. 🟢 iPad: Avslutte appen når det velges et nytt sted
          🟣🟣🟣🟣 Dette er en feil i iPadOS 21D5026f, så jeg avventer oppdatering.
          🟢 Dette er ikke et problem lenger med de siste oppdateringene.
   83. 🟢 Behandle når noen "Innstillinger" mangler.
          🟢 Åpner SettingsView()
   84. 🟢 Vise endringen av lengden av degen fra en dag til en annen
   85. 🟢 "No placeName" og "No countryName"
          🟢 let noPlaceName: String = String(localized: "No placeName")
          🟢 let noCountryName: String = String(localized: "No countryName")
   86. 🟢 Lagring virker ikke !!!!! fra "Søk etter"
          🟣 Det tar bare veldig lang til å oppdatere CloudKit
   87. 🟢 Krasjer noen ganger med manglende månenedgang FindTimeFromAmPm()
          🟢 Månenedgang
          🟢 Måneoppgang
   88. 🟢 Flere .alert ref. WeatherForecast.swift
   89. 🟢 "Lokal værmelding" sin meny må endres:
          🟢 Legg inn "Lagre dette stedet"
          🟢 Legg inn riktig flagg på de lokale stedene jeg har lagret.
          🟢 Legg inn "Avbryt"
   90. 🟢 "Mine steder" sin meny må endres:
          🟢 legg inn "Slett dette stedet"
          🟢 Legg inn "Avbryt"
   91. 🟢 "Søk etter" sin meny må endres:
          🟢 Legg inn Meny (lagres direkte i dag):
             🟢 Legg inn "Lagre"
             🟢 Legg inn "Avbryt"
   92. 🟢 Lage oversikt over alle landene:
          🟢 API som returnerer JSON :  "https://restcountries.com/v3.1/all?fields=name,cca2,flag"
          🟢 Lage denne listen
          🟢 Oppdatere Localizable.strings
          🟢 Oppdatere TranslateCountry(country: String) -> String
   93. 🟢 Tilpaaset vertikal/horisontal Views for iPone og IPad
   94. 🟣 Sjekk månen rundt 100% (månen vises ikke)
   95. 🟢 Legge inn et varselsfelt om snø helt øverst på skjermen
          🟢 Lage skjermbildet
          🟢 Hente data fra global variabel dailyForecast
   96. 🟢 Tilpasse bredden på Views fra "DAG OVERSIKT"
   97. 🟢 Korrekt horzontal bredde
          🟢 Bruker GeometryReader for å finne bredde og høyde
          🟢 Tilpasse bredden på "Dagen" SunDayAndNight()
   98. 🟢 Gå gjennom dismiss
          🟢 @Environment(\"."dismiss) var dismiss
   99. 🟢 Legge inn avstand under bl.a. Værforhold
  100. 🟢 Justere X kalt fra "DAG OVERSIKT" (litt til venstre)
  101. 🟢 Endre på bredden på "I dag" og "I går"
          🟢 Værforhold
          🟢 UV-indeks
          🟢 Vind
          🟢 Luftfuktighet
  102. 🟢 Legge inn settings for:
          🟢 https://restcountries.com/v3.1/all?fields=name,cca2,flag,capital,population  
  103. 🟢 Legg søkefelt på land
  104. 🟢 DayDetailHourIconsModifier() må tilpasse bredden for:
          🟢 Værforhold
          🟢 UV-indeks
          🟢 Vind
          🟢 Føles som
          🟢 Luftfuktighet
          🟢 Sikt
          🟢 Lufttrykk
  105. 🟢 Tilpasse DayDetailIcons() avhengig av screenSize.screenWidth:
          🟢 Værforhold + klokkeslett
          🟢 UV-indeks + klokkeslett
          🟢 Vind
          🟢 Føles som
          🟢 Luftfuktighet
          🟢 Sikt
          🟢 Lufttrykk  
  106. 🟢 Nye tilpasninger fra Apple "Været"
          🟢 Gjennomsnittsverdier temperatur
          🟢 Gjennomsnittsverdier nedbør
  107. 🟢 Erstatte Geosatellite fra met.no
  108. 🟢 Sjekk server response fra:
          🟢 FindCurrentLocation()
          🟢 GetAverageDayWeather()
          🟢 'dailyForecast'
          🟢 'hourForecast'
          🟢 FindSunUpDown()
          🟢 FindMoonUpDown()
          🟢 'weather'
          🟢 FindAirQuality()   
   109. 🟢 Bytte visning av Chance of Percipitation 
          🟢 LineChart
   110. 🟢 InfoHumidity:  
          🟢 Rette tekst for "i dag" og en annen dag
   111. 🟢 InfoFeelsLike:  
          🟢 legg inn sammenligning: i går og idag
   112. 🔴 Visibility:  
          🔴 legg inn sammenligning: i går og idag
   113. 🔴 AirPressure 
           🔴 egg inn sammenligning: i går og idag
   114. 🔴 Precipitation24h:
          🔴 Fast y verdi ?
          🔴 Markere mye, moderat og lett hvor ?
   115. 🔴 .  
          🔴 .
   116. 🔴 .  
          🔴 .


🌕 Hvor lenge Månen er i hvert tegn?

Månen bruker omtrent 27,3 dager på å gå én runde rundt Jorden (sin bane).
Den beveger seg gjennom alle 12 tegn på ca. 27–28 dager, altså:
➤ Ca. 2,5 dager (60–65 timer) i hvert tegn.

♈️ 1. Væren (Aries)
Element: Ild 🔥
Modalitet: Kardinal
Dato (soltegn): ca. 21. mars – 19. april
Nøkkelord: Initiativ, energi, mot, handling 

♉️ 2. Tyren (Taurus)
Element: Jord 🌍
Modalitet: Fast
Dato: ca. 20. april – 20. mai
Nøkkelord: Stabilitet, sanselighet, tålmodighet, trygghet

♊️ 3. Tvillingene (Gemini)
Element: Luft 🌬️
Modalitet: Bevegelig
Dato: ca. 21. mai – 20. juni
Nøkkelord: Kommunikasjon, læring, fleksibilitet

♋️ 4. Krepsen (Cancer)
Element: Vann 💧
Modalitet: Kardinal
Dato: ca. 21. juni – 22. juli
Nøkkelord: Følelser, hjem, omsorg, beskyttelse

♌️ 5. Løven (Leo)
Element: Ild 🔥
Modalitet: Fast
Dato: ca. 23. juli – 22. august
Nøkkelord: Selvtillit, kreativitet, lederskap

♍️ 6. Jomfruen (Virgo)
Element: Jord 🌍
Modalitet: Bevegelig
Dato: ca. 23. august – 22. september
Nøkkelord: Orden, analyse, tjeneste, detaljer

♎️ 7. Vekten (Libra)
Element: Luft 🌬️
Modalitet: Kardinal
Dato: ca. 23. september – 22. oktober
Nøkkelord: Balanse, skjønnhet, relasjoner

♏️ 8. Skorpionen (Scorpio)
Element: Vann 💧
Modalitet: Fast
Dato: ca. 23. oktober – 21. november
Nøkkelord: Dybde, transformasjon, intensitet

♐️ 9. Skytten (Sagittarius)
Element: Ild 🔥
Modalitet: Bevegelig
Dato: ca. 22. november – 21. desember
Nøkkelord: Eventyr, visdom, frihet

♑️ 10. Steinbukken (Capricorn)
Element: Jord 🌍
Modalitet: Kardinal
Dato: ca. 22. desember – 19. januar
Nøkkelord: Ambisjon, struktur, ansvar

♒️ 11. Vannmannen (Aquarius)
Element: Luft 🌬️
Modalitet: Fast
Dato: ca. 20. januar – 18. februar
Nøkkelord: Originalitet, frihet, samfunn, innovasjon

♓️ 12. Fiskene (Pisces)
Element: Vann 💧
Modalitet: Bevegelig
Dato: ca. 19. februar – 20. mars
Nøkkelord: Intuisjon, drømmer, medfølelse

Zodiaken går altså i en evig sirkel, hvor Fiskene avslutter runden – før Væren starter syklusen på nytt.  



"""

struct ToDoView: View {
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading, spacing: 10) {
                Text(toDo_1)
                    .foregroundColor(.red)
                Text(toDo_2)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.leading, 10)
            .navigationTitle("toDo")
        }
    }
}
/*
@Environment(\.dismiss) var dismiss
 */

