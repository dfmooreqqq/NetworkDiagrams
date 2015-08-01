# Load packages.
packages <- c("gdata", "ggplot2", "plyr", "reshape2", "tm", "dplyr", "igraph", "data.table", "sna")
packages <- lapply(packages, FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
        install.packages(x)
        library(x, character.only = TRUE)
    }
})

source("http://bioconductor.org/biocLite.R")
biocLite("Rgraphviz")

setwd("c:/users/damoore/desktop/")
XDSE_nodes<-read.csv("XDSE_Nodes.csv")
XDSE_nodes_matrix<-as.matrix(read.csv("XDSE_Nodes_Matrix.csv", header = FALSE))
colnames(XDSE_nodes_matrix)<-c("AACS 2.0",    "BD Player Application",	"Cert",	"CODECs",	"Display Out",	"HDCP",	"HDCP RX 1.4",	"HDCP TX 1.4",	"HDCP TX 2.2",	"HDMI Certification",	"HDMI In",	"HDR",	"HEVC",	"Hulu Plus",	"Legacy",	"Legacy Display In",	"Multi-stream",	"Netflix",	"Pre-HEVC",	"Source Material",	"Streaming Application",	"UHD",	"UHD Streaming",	"UHD-BD Playback",	"Xbox Video")
rownames(XDSE_nodes_matrix)<-c("AACS 2.0",    "BD Player Application",	"Cert",	"CODECs",	"Display Out",	"HDCP",	"HDCP RX 1.4",	"HDCP TX 1.4",	"HDCP TX 2.2",	"HDMI Certification",	"HDMI In",	"HDR",	"HEVC",	"Hulu Plus",	"Legacy",	"Legacy Display In",	"Multi-stream",	"Netflix",	"Pre-HEVC",	"Source Material",	"Streaming Application",	"UHD",	"UHD Streaming",	"UHD-BD Playback",	"Xbox Video")

am.graph<-new("graphAM", adjMat=XDSE_nodes_matrix, edgemode="directed")
am.graph
plot(am.graph, attrs = list(node = list(fillcolor = "lightblue", fontsize = 46),edge = list(arrowsize=0.5)))
gplot(XDSE_nodes_matrix, displaylabels=TRUE)
XDSE_nodes_degree<-degree(XDSE_nodes_matrix)
XDSE_nodes_evcent<-evcent(XDSE_nodes_matrix)
XDSE_nodes_closeness<-closeness(XDSE_nodes_matrix)
XDSE_nodes_geodist<-geodist(XDSE_nodes_matrix)


