#Installation of additional packages to work similarly as in RStudio
#install.packages("httpgd")
#install.packages("rmarkdown")
#install.packages("knitr")
#install.packages("colorRamps")
#install.packages("ggplot2")
#install.packages("reshape")
#install.packages("scales")
#install.packages("vegan")
#install.packages("devtools")
#install.packages("DiagrammeR")
#install.packages("grid")
#install.packages("rlang")
#BiocManager::install("treeio")
#install.packages("yulab.utils")
#remotes::install_github('YuLab-SMU/ggtree')
#devtools::install_github("jaredhuling/jcolors")
#devtools::install_github("vmikk/metagMisc", force = T)

#if (!require("BiocManager" install.packages("quietly") = TRUE))
#    install.packages("BiocManager")
#BiocManager::install("phyloseq")
#BiocManager::install("microbiome", force = T)
#BiocManager::install("DESeq2", force = T)
#BiocManager::install("dada2" , force = T)
#BiocManager::install("ALDEx2", force = T)
#BiocManager::install("metagenomeSeq", force = T)
#BiocManager::install("microbiomeMarker", force = T)

# Libraries required
library("httpgd")
library("rmarkdown")
library("knitr")
library("colorRamps")
library("ggplot2")
library("reshape")
library("scales")
library("jcolors")
library("grid")
library("RColorBrewer")
library("dplyr")
library("ggpubr")
library("phyloseq")
library("microbiome")
library("vegan")
library("metagMisc")
library("DiagrammeR")
library("microbiomeMarker")


readcountraw <- read.delim("/home/pscorp28/samsa2FVP/metatrans-colab/01_pretreatment_FVP/resumendesecuencias.txt",
                        header=TRUE,
                        sep="\t",
                        check.names = FALSE)

# Reshape of matrix
readcount <- melt(readcountraw,
                  id.vars="IDs")
# Plot
barplot_rawdata_quality <- ggplot(data = readcount) +
geom_col(aes(x = IDs,
             y = value,
             fill = variable),
         position=position_dodge()) +
  labs(x = "",
       y = "Número de lecturas",
       title="Conteo de lecturas pretratamiento") +
scale_x_discrete(expand = c(0, 0)) +
scale_y_continuous(expand = c(0, 0)) +
theme_test() +
theme(text = element_text(size = 14),
      legend.title = element_blank(),
      axis.text.x = element_text(size = 5,
                                 angle = 90,
                                 hjust = 1,
                                 vjust = 0.5))

# SVG creation
svg(filename = "barplot_rawdata_quality.svg",
    width = 7,
    height = 4)
  print(barplot_rawdata_quality)
dev.off()


data<-c("Promedio")
raw<-round(mean(readcountraw$'Secuencias crudas'), digits = 0)
trim<-round(mean(readcountraw$'Trimmomatic QC'),digits = 0)
ave <-data.frame(data, raw,trim)
colnames(ave) <-colnames(readcountraw)


# Reshape of matrix
ave <- melt(ave)
ave

# Plot
barplot_rawdata_quality_group <- ggplot(data = ave) +
geom_col(aes(x = variable,
             y = value,
             fill = variable),
         position=position_dodge()) +
  labs(x = "",
       y = "Número de lecturas",
       title="Conteo de lecturas pretratamiento") +
scale_x_discrete(expand = c(0, 0)) +
scale_y_continuous(expand = c(0, 0)) +
theme_test() +
theme(text = element_text(size = 14),
      legend.title = element_blank(),
      axis.text.x = element_text(hjust = 0.5))

barplot_rawdata_quality_group

# SVG creation
svg(filename = "barplot_rawdata_quality_group.svg",
    width = 7,
    height = 4)
  print(barplot_rawdata_quality_group)
dev.off()






