library(data.table)
library(dplyr)

fname <- 'household_power_consumption.txt'

before_date <- as.Date('2007-02-01')
after_date <- as.Date('2007-02-02')

# guard to avoid re-reading data
if (!exists("tdata") || (!exists("last_fname") || last_fname != fname)) {
  
  # read and massage the data
  last_fname <- fname
  tdata <- (
    fread(fname, sep=';', na.strings = '?', showProgress = TRUE) %>%
    mutate(date = as.Date(Date, '%d/%m/%Y')) %>%
    filter(date >= before_date & date <= after_date) %>%
    mutate(dtime = strptime(paste(Date,Time), '%d/%m/%Y %H:%M:%S'))
  )
  
}

setupPlot <- function(pngName) {
  
  #explicitly size the png per the instructions
  png(pngName, width = 480, height = 480)
  
}

plot_global_active_power_frequency <- function() {
  
  gapLabel <- 'Global Active Power (kilowatts)'
  
  #make our plot
  with(tdata, hist(Global_active_power, col='red', main='Global Active Power', xlab=gapLabel))
  
}

plot_global_active_power <- function() {
  
  gapLabel <- 'Global Active Power (kilowatts)'
  
  #make our plot
  with(tdata, plot(dtime, Global_active_power, type='l', xlab='', ylab=gapLabel))
}

plot_energy_sub_metering <- function() {
  
  energyLbl <- 'Energy sub metering'
  
  #make our plot
  with(tdata, {
    plot(dtime, Sub_metering_1, 
         type='l', col='black', xlab='', ylab=energyLbl)
    lines(dtime, Sub_metering_2, col='red')
    lines(dtime, Sub_metering_3, col='blue')
    legend('topright',
           legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
           col = c('black','red','blue'),
           lty = 1)
  })
  
}

plot_voltage <- function() {
  with(tdata, {
    plot(dtime, Voltage, type='l', col='black', xlab='datetime')
  })
}

plot_reactive_power <- function() {
  with(tdata, {
    plot(dtime, Global_reactive_power, type='l', col='black', xlab='datetime')
  })
}