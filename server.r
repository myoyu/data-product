library(UsingR)
shinyServer(
  function(input, output) {
    output$chart <- renderPlot({
      county = input$county
      selectedCounty = countyFIPS[countyFIPS['CountyName'] == county]  
      selectedCountyFIPS = gsub(" ", "", paste(c(selectedCounty[3],selectedCounty[4]),collapse = ''))
      #Filter the data for selected City only
      citydata = subset(NEI,fips %in% selectedCountyFIPS);
      #cumulate emission over years
      emissionsHistbyYear = aggregate(Emissions ~ year,data=citydata,FUN="sum");
      
      with(emissionsHistbyYear, plot(year, Emissions, , xlab = "Year", ylab = "Total Emissions (tons)", type = "o", col = "blue", xaxt="n", main = paste(c("Total PM2.5 Emissions in", county),collapse = ' ')))
      axis(1, at=emissionsHistbyYear$year, labels=emissionsHistbyYear$year, las=2);
      legend("topright", lty=c(1,1), col = c("green","blue"), legend = c("Trend line","Emissions"));
      #add trend line
      model = lm(Emissions ~ year, emissionsHistbyYear);
      abline(model, col="green", lwd = 2);
      if (model$coefficients[2] < 0)
      {
        x=(max(emissionsHistbyYear$year)+min(emissionsHistbyYear$year))/2;
        y=model$coefficients[2]*x+model$coefficients[1];
        text(x, y, "Decreasing", pos=2, col="green");  
      }else
      {
        x=(max(emissionsHistbyYear$year)+min(emissionsHistbyYear$year))/2;
        y=model$coefficients[2]*x+model$coefficients[1];  
        text(x,y, "Increasing", pos=2, col="green");    
      }
    })
  }
)
