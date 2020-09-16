library(xlsx)
library(darksky)
library(data.table)
data=read.xlsx("D:/Verizon/Version_2/modeling/weather_location.xlsx",1,stringsAsFactors=F)
longi=data[,4]   ##List of longitudes
lat=data[,3]     ##List of latitudes
loc_id=data[,1]  ## Location mapping (Please ignore)
enodeb=data[,2]  ## Network tower number (Please ignore)
#data2=data

# df=read.csv("201812.csv",1,sep=',',stringsAsFactors=F)
st <- as.Date("2019-01-01")  ## Start date of the data to downloaded
en <- as.Date("2019-12-31")  ## End date of the data to downloaded
dates_list <- seq(en, st, by = "-1 day")   ## Storing dates in a list to loop it over
req_data= vector(mode="list",length=365)


count=0
#### Change count in loop for column headers before next loop

for (j in 1:100){ 
for (i in 1:365){
  data= get_forecast_for(lat[j],longi[j], paste(dates_list[366-i],'T12:00:00-0400',sep=''), add_headers=TRUE)      #ifelse(count==0,TRUE,FALSE))  
  a=data[1]
  a_df=as.data.frame(a)
  b=cbind(loc_id=loc_id[j],enode_b=enodeb[j],Longitude=longi[j],Latitude=lat[j],day_hr=a_df$hourly.time,summary=a_df$hourly.summary, icon=a_df$hourly.icon,precipIntensity=a_df$hourly.precipIntensity,precipProbability=a_df$hourly.precipProbability,temperature=a_df$hourly.temperature,apparentTemperature=a_df$hourly.apparentTemperature,dewPoint=a_df$hourly.dewPoint,humidity=a_df$hourly.humidity,pressure=a_df$hourly.pressure,windSpeed=a_df$hourly.windSpeed,windGust=a_df$hourly.windGust,windBearing=a_df$hourly.windBearing,cloudCover=a_df$hourly.cloudCover,uvIndex=a_df$hourly.uvIndex,visibility=a_df$hourly.visibility,ozone=a_df$hourly.ozone,precipType=a_df$hourly.precipType)
  write.table(b,"D:/Verizon/Version_2/modeling/weather_data/D1.csv", append = ifelse(count==0,FALSE,TRUE),row.names = TRUE,col.names= ifelse(count==0,TRUE,FALSE),sep=",")
  count=count+1
  print(paste(j,i,sep = "-"))
  
}
}

