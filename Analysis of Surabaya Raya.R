library(readxl)
library(openxlsx)
library("factoextra")
library("FactoMineR")
library(ca)
library(nnet)
library(caret)
library(MASS)
library(ggcorrplot)
library(rcompanion)
library(corrplot)
library("effects")
library(ggplot2)
library(stargazer)

merged_data <- read_excel("cleaning data/cutoff/merged data.xlsx",
                          sheet = "Sheet1")
colnames(merged_data)=c("Provinsi","Kota","Tk.Kepatuhan","Usia","Pendidikan",
                        "Tk.Keramaian","Protokol3M","Tk.Efektifitas",
                        "Masker","Cuci","Handsanitizer","Jarak","Wilayah")
unique(merged_data$Kota)
sbyr_data=subset(merged_data,Kota=="KOTA SURABAYA" | 
                   Kota=="KABUPATEN SIDOARJO" | 
                   Kota=="KABUPATEN GRESIK" |
                   Kota=="KOTA MOJOKERTO" )
sbyr_data=data.frame(sbyr_data)
unique(sbyr_data$Kota)
for (i in 2:NCOL(sbyr_data)) {
  print(paste(colnames(sbyr_data)[i],": ",length(unique(sbyr_data[,i]))))
}

unique(sbyr_data$Tk.Kepatuhan)
sbyr_data$Tk.Kepatuhan=factor(sbyr_data$Tk.Kepatuhan,
                             levels = c("Kurang Penting",
                                        "Masih sangat penting",
                                        "Penting"),
                             ordered = F)
unique(sbyr_data$Usia)
sbyr_data$Usia=factor(sbyr_data$Usia,
                     levels = c("< 17 tahun","17-25 tahun",
                                "26-40 tahun",">40 tahun"),
                     ordered = F)
unique(sbyr_data$Pendidikan)
sbyr_data$Pendidikan=factor(sbyr_data$Pendidikan,
                           levels = c("Tidak sekolah/tidak lulus SD",
                                      "SD/SMP","SMU/sederajat",
                                      "Sarjana"),
                           ordered = F)
unique(sbyr_data$Tk.Keramaian)
sbyr_data$Tk.Keramaian=factor(sbyr_data$Tk.Keramaian,
                             levels = c("Ramai","Sangat ramai"),
                             ordered = F)
unique(sbyr_data$Protokol3M)
sbyr_data$Protokol3M=as.factor(sbyr_data$Protokol3M)
unique(sbyr_data$Tk.Efektifitas)
sbyr_data$Tk.Efektifitas=factor(sbyr_data$Tk.Efektifitas,
                               levels = c("Tidak","Belum tentu","Iya"),
                               ordered = F)
unique(sbyr_data$Masker)
sbyr_data$Masker=factor(sbyr_data$Masker,
                       levels = c("Tidak pernah menggunakan masker",
                                  "Sangat jarang menggunakan masker",
                                  "Kadang-kadang menggunakan masker",
                                  "Selalu menggunakan masker"),
                       ordered = F)
unique(sbyr_data$Cuci)
sbyr_data$Cuci=factor(sbyr_data$Cuci,
                        levels = c("Tidak pernah masker",
                                   "Kadang-kadang",
                                   "Sangat sering"),
                        ordered = F)
unique(sbyr_data$Handsanitizer)
sbyr_data$Handsanitizer=factor(sbyr_data$Handsanitizer,
                              levels = c("Tidak pernah membawa",
                                         "Kadang-kadang membawa",
                                         "Selalu membawa"),
                              ordered = F)
unique(sbyr_data$Jarak)
sbyr_data$Jarak=factor(sbyr_data$Jarak,
                      levels = c("Tidak pernah menjaga jarak",
                                 "Kadang-kadang menjaga jarak",
                                 "Selalu menjaga jarak"),
                      ordered = F)
unique(sbyr_data$Kota)
sbyr_data$Kota=factor(sbyr_data$Kota, 
                      levels = c("KOTA SURABAYA","KABUPATEN SIDOARJO",
                                 "KABUPATEN GRESIK", "KOTA MOJOKERTO"), 
                      ordered = F)

# ggcorrplot
matr=matrix(data = NA,nrow = NCOL(sbyr_data)-2, ncol = NCOL(sbyr_data)-2)
colnames(matr)=rownames(matr)=colnames(sbyr_data[,-c(1,13)])
for (i in 1:(NCOL(sbyr_data)-2)) {
  for (j in 1:(NCOL(sbyr_data)-2)) {
    matr[i,j]=cramerV(x=sbyr_data[,i+1],y=sbyr_data[,j+1])
  }
}

matr.sign=matr
for (i in 1:(NCOL(sbyr_data)-2)) {
  for (j in 1:(NCOL(sbyr_data)-2)) {
    a=chisq.test(x=sbyr_data[,i+1],y=sbyr_data[,j+1],simulate.p.value = T)
    matr.sign[i,j]=a$p.value
  }
}

ggcorrplot(matr[-1,-1], type = "upper", lab = T, p.mat = matr.sign[-1,-1], sig.level = 0.1) + 
  scale_fill_gradient2(low = "white", high = "blue", breaks=c(0, 1), 
                       limit=c(0, 1),  name = "Cramer's V")

# analisis korespondensi
tabel.sby=table(sbyr_data$Tk.Kepatuhan,sbyr_data$Jarak)
ca.tabel.sby=CA(tabel.sby)
fviz_ca_biplot(ca.tabel.sby, 
               map ="rowprincipal", arrow = c(TRUE, TRUE),
               repel = TRUE)

# regresi
na.row=which(is.na(sbyr_data$Tk.Keramaian))
sbyr_data$Tk.Keramaian[na.row]="Ramai"
str(sbyr_data)
colSums(is.na(sbyr_data))

fit=multinom(Tk.Kepatuhan~.,data = sbyr_data[,-c(1,13)])
fit=step(fit, direction = "backward")
stargazer(fit, type = "text")
plot(Effect(focal.predictors = "Jarak", fit))
a=allEffects(fit)
a$Handsanitizer

write.xlsx(sbyr_data$Wilayah,"sheet_bantuan_sby_raya.xlsx")
count_bantuan_sby_raya <- read_excel("count_bantuan_sby_raya.xlsx")
wd.bantuan.sby.raya<-data.frame(colnames(count_bantuan_sby_raya[,-1]),
                           colSums(count_bantuan_sby_raya[,-1]))
colnames(wd.bantuan.sby.raya)<-c("Word","Freq")
wd.bantuan.sby.raya=wd.bantuan.sby.raya[order(-wd.bantuan.sby.raya$Freq),]
head(wd.bantuan.sby.raya,20)
wordcloud2(data = subset(wd.bantuan.sby.raya, Freq>1), size = 1, 
           rotateRatio = 0)
