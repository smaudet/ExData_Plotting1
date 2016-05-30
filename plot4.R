source('common.R')

# setup the canvas
setupPlot('plot4.png')
par(mfrow = c(2,2))

# plot - see common.R for the implementation

plot_global_active_power() # note that this implements the ^ top    < left  plot
plot_voltage()             # note that this implements the ^ top    > right plot

plot_energy_sub_metering() # note that this implements the v bottom < left  plot
plot_reactive_power()      # note that this implements the v bottom > right plot

dev.off()