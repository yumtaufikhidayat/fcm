#Fuzzy C-Means 550 data

#impor dataset (1)
impor.dataset <- read.csv(file.choose(), header = TRUE) 
View(impor.dataset)

#menghapus nilai yang hilang pada data (2)
ds<-impor.dataset
df<-na.omit(ds)
x<-df[-1]

#standarisasi data (3)
sd<-scale(x)
View(sd)

#proses fuzzy c-means dengan K=3 (4)
library(cluster)
proses.fcm <- fanny(sd, 3, metric = "euclidean", stand = FALSE)
proses.fcm

#menambahkan kolom cluster ke data asli
dd<-cbind(impor.dataset, cluster = proses.fcm$cluster)
View(dd)

#plot/visualsasi (5)
library(factoextra)
library(ggplot2)
fviz_cluster(proses.fcm, data = sd)

#validasi dengan DBI (Davies-Bouldin Index) (6)
library(NbClust)
DBIFCM<-NbClust(sd, distance = "euclidean",
                 min.nc = 2, max.nc = 5,
                 index = "db", method = "average")
DBIFCM$Best.nc #rekomendasi jumlah kluster terbaik dan nilai validasinya
DBIFCM$All.index #banyaknya jumlah kluster dan nilai validasinya masing-masing

#validasi dengan SI (Silhouette Index) (6)
library(NbClust)
SIFCM<-NbClust(sd, distance = "euclidean",
                min.nc = 2, max.nc = 5,
                index = "silhouette", method = "average")
SIFCM$Best.nc #rekomendasi jumlah kluster terbaik dan nilai validasinya
SIFCM$All.index #banyaknya jumlah kluster dan nilai validasinya masing-masing
