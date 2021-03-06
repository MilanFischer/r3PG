# This script processes raw data files into RDA files for loading by users

# Example config file
  example.config <- load_config("raw_data/default.cfg")
  example.config$TimeRange$StartAge
  example.config$TimeRange$InitialMonth <- 1
  example.config$TimeRange$EndMonth <- 12
  example.config$TimeRange$MonthPlanted <- 1
  
  save(example.config, file = "data/example.config.RData")

# Example climate file
  example.clim <- read.csv("raw_data/default.csv")
  example.clim <- example.clim[,c("Tav","VPD","Rain","Solar.rad","Frost.Days","Ca","D13Catm","d18O","Year","Month")]
  save(example.clim, file = "data/example.clim.RData")

# Read species data
  spp_table <- read.csv("raw_data/spp_edits.csv", stringsAsFactors = FALSE)
    
    new.names <- spp_table$Name
    cfg.names <- unlist(lapply(strsplit(x = names(unlist(example.config)), split = "\\."), function(x){x[2]}))
      
      new.names[new.names == "Tmin"] <- "T_min"
      new.names[new.names == "Topt"] <- "T_opt"
      new.names[new.names == "Tmax"] <- "T_max"
      
      spp_table[spp_table$Name == "Tmin","Name"] <- "T_min"
      spp_table[spp_table$Name == "Topt","Name"] <- "T_opt"
      spp_table[spp_table$Name == "Tmax","Name"] <- "T_max"      
      
      
        new.names <- new.names[!new.names %in% c("aS","nS","gammaR","SWconst","SWpower","fNn","rhoMin","rhoMax","tRho","aH","nHB","nHN","aV","nVB","nVN","Qa","Qb","gDM_mol","molPAR_MJ","fCalpha700","fCg700","MinCond","gammaNx","gammaN0","tgammaN","ngammaN")]
  
      # assumed that "SWconst0" and "SWpower0" ar not the same as "SWconst" and "SWpower"
        
    new.names[!new.names %in% cfg.names]
    cfg.names[!cfg.names %in% new.names]
    
    spp_table <- spp_table[spp_table$Name %in% new.names,]
    
    all(spp_table$Name == new.names)    
    
    names(example.config)
    
    # CREATE NEW CONFIGS
    
      spp <- names(spp_table)[5:11]
    
      for(i in spp){
        
        tmp.cfg.name <- paste("cfg.", i, sep = "")
        orig.cfg <- example.config
        
        spp_table
        
        new.cfg <- list()
        
        for(j in unique(spp_table$Category)){
          
          tmp.tab <- spp_table[spp_table$Category == j, ]
          
          tmp.cfg <- list()
          
          for(k in tmp.tab$Name){
            
            tmp.cfg[k] <- tmp.tab[tmp.tab$Name == k,i]
            
          }
          
          new.cfg[[j]] <- tmp.cfg
          
        }
        
        out.list <- modifyList(orig.cfg, new.cfg)
        
        assign(x = tmp.cfg.name, value = out.list)
        
      }
      
  save(cfg.Eucalyptus.globulus, file = "data/cfg.Eucalyptus.globulus.RData")      
  save(cfg.Picea.sitchensis, file = "data/cfg.Picea.sitchensis.RData")      
  save(cfg.Pinus.contorta, file = "data/cfg.Pinus.contorta.RData")      
  save(cfg.Pinus.ponderosa, file = "data/cfg.Pinus.ponderosa.RData")      
  save(cfg.Pinus.radiata, file = "data/cfg.Pinus.radiata.RData")      
  save(cfg.Pinus.taeda, file = "data/cfg.Pinus.taeda.RData")      
  save(cfg.Pseudotsuga.menziesii, file = "data/cfg.Pseudotsuga.menziesii.RData")      
      
# Read climate data      
  
  data("example.clim")
    head(example.clim, 12)
      
  clim.Argentina <- read.csv("raw_data/clim-Argentina.csv") 
  clim.BritishColumbia <- read.csv("raw_data/clim-BritishColumbia.csv") 
  clim.NorthCarolina <- read.csv("raw_data/clim-NorthCarolina.csv") 
  clim.WesternOR <- read.csv("raw_data/clim-western-OR.csv") 
    
      tmp <- clim.Argentina
      tmp$Tav <- apply(X = cbind(tmp$Tmax,tmp$Tmin), MARGIN = 1, FUN = mean)
      tmp$VPD <- r3PG:::get_VPD(T_max = tmp$Tmax, T_min = tmp$Tmin) 
      tmp$Ca <- tail(example.clim$Ca, 12)
      tmp$D13Catm <- tail(example.clim$D13Catm, 12)
      tmp$d18O <- tail(example.clim$d18O, 12)  
      tmp$Tmax <- tmp$Tmin <- NULL
      clim.Argentina <- tmp
    
      tmp <- clim.BritishColumbia
      tmp$Tav <- apply(X = cbind(tmp$Tmax,tmp$Tmin), MARGIN = 1, FUN = mean)
      tmp$VPD <- r3PG:::get_VPD(T_max = tmp$Tmax, T_min = tmp$Tmin) 
      tmp$Ca <- tail(example.clim$Ca, 12)
      tmp$D13Catm <- tail(example.clim$D13Catm, 12)
      tmp$d18O <- tail(example.clim$d18O, 12)  
      tmp$Tmax <- tmp$Tmin <- NULL
      clim.BritishColumbia <- tmp    
        
      tmp <- clim.NorthCarolina
      tmp$Tav <- apply(X = cbind(tmp$Tmax,tmp$Tmin), MARGIN = 1, FUN = mean)
      tmp$VPD <- r3PG:::get_VPD(T_max = tmp$Tmax, T_min = tmp$Tmin) 
      tmp$Ca <- tail(example.clim$Ca, 12)
      tmp$D13Catm <- tail(example.clim$D13Catm, 12)
      tmp$d18O <- tail(example.clim$d18O, 12)  
      tmp$Tmax <- tmp$Tmin <- NULL
      clim.NorthCarolina <- tmp
    
      tmp <- clim.WesternOR
      tmp$Tav <- apply(X = cbind(tmp$Tmax,tmp$Tmin), MARGIN = 1, FUN = mean)
      tmp$VPD <- r3PG:::get_VPD(T_max = tmp$Tmax, T_min = tmp$Tmin) 
      tmp$Ca <- tail(example.clim$Ca, 12)
      tmp$D13Catm <- tail(example.clim$D13Catm, 12)
      tmp$d18O <- tail(example.clim$d18O, 12)  
      tmp$Tmax <- tmp$Tmin <- NULL
      clim.WesternOR <- tmp    
    
par(mfrow = c(1,2))

  with(clim.WesternOR, plot(Tav ~ c(1:12), type = "l", ylab = NA, xlab = "", ylim = c(-20,40), 
                            xaxt = "n", col = "dodgerblue", main = "Mean Temperature"))
    with(clim.Argentina, lines(y = Tav, x = c(1:12), col = "darkorange"))    
    with(clim.BritishColumbia, lines(y = Tav, x = c(1:12), col = "darkgreen"))    
    with(clim.NorthCarolina, lines(y = Tav, x = c(1:12), col = "purple"))    
        axis(side = 1, at = c(1:12), labels = month.abb, las = 2)
        
  with(clim.WesternOR, plot(Rain ~ c(1:12), type = "l", ylab = NA, xlab = "", ylim = c(0,500), 
                            xaxt = "n", col = "dodgerblue", main = "Mean Temperature"))
    with(clim.Argentina, lines(y = Rain, x = c(1:12), col = "darkorange"))    
    with(clim.BritishColumbia, lines(y = Rain, x = c(1:12), col = "darkgreen"))    
    with(clim.NorthCarolina, lines(y = Rain, x = c(1:12), col = "purple"))    
        axis(side = 1, at = c(1:12), labels = month.abb, las = 2)
                
        
      
  save(clim.Argentina, file = "data/clim.Argentina.RData")      
  save(clim.BritishColumbia, file = "data/clim.BritishColumbia.RData")      
  save(clim.NorthCarolina, file = "data/clim.NorthCarolina.RData")      
  save(clim.WesternOR, file = "data/clim.WesternOR.RData")        
      
      
      
      
      
      
    