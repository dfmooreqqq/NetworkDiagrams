#### Environment setup ####
# Load packages.
packages <- c("ggplot2", "igraph","sna")
packages <- lapply(packages, FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
        install.packages(x)
        library(x, character.only = TRUE)
    }
})

# source("http://bioconductor.org/biocLite.R")
# biocLite("Rgraphviz")
# library("Rgraphviz")

#### Set working directory ####
workingdir<-paste("C:\\Users", Sys.getenv("USERNAME"), "Documents\\GitHub\\NetworkDiagrams", sep = "\\")
setwd(workingdir)

#### Read in and setup files ####
XDSE_nodes<-read.csv("XDSE_Nodes.csv")
#XDSE_nodes_matrix<-as.matrix(read.csv("XDSE_Nodes_Matrix.csv", header = FALSE))
#colnames(XDSE_nodes_matrix)<-c("AACS 2.0",    "BD Player Application",	"Cert",	"CODECs",	"Display Out",	"HDCP",	"HDCP RX 1.4",	"HDCP TX 1.4",	"HDCP TX 2.2",	"HDMI Certification",	"HDMI In",	"HDR",	"HEVC",	"Hulu Plus",	"Legacy",	"Legacy Display In",	"Multi-stream",	"Netflix",	"Pre-HEVC",	"Source Material",	"Streaming Application",	"UHD",	"UHD Streaming",	"UHD-BD Playback",	"Xbox Video")
#rownames(XDSE_nodes_matrix)<-c("AACS 2.0",    "BD Player Application",	"Cert",	"CODECs",	"Display Out",	"HDCP",	"HDCP RX 1.4",	"HDCP TX 1.4",	"HDCP TX 2.2",	"HDMI Certification",	"HDMI In",	"HDR",	"HEVC",	"Hulu Plus",	"Legacy",	"Legacy Display In",	"Multi-stream",	"Netflix",	"Pre-HEVC",	"Source Material",	"Streaming Application",	"UHD",	"UHD Streaming",	"UHD-BD Playback",	"Xbox Video")
XDSE_nodes<-XDSE_nodes[order(rank(XDSE_nodes$Node.1, XDSE_nodes$Node.2)),]
a<-get.adjacency(graph.edgelist(as.matrix(XDSE_nodes), directed=TRUE))
XDSE_nodes_matrix1<-as.matrix(a)

#### Graphs and Analysis ####
am.graph1<-new("graphAM", adjMat=XDSE_nodes_matrix1, edgemode="directed")
am.graph1
plot(am.graph1, attrs = list(node = list(fillcolor = "lightblue", fontsize = 46),edge = list(arrowsize=0.5)))
gplot(XDSE_nodes_matrix1, displaylabels=TRUE)
XDSE_nodes_stats<- data.frame(
    degree=sna::degree(XDSE_nodes_matrix1),
    evcent=sna::evcent(XDSE_nodes_matrix1),
    closeness=sna::closeness(XDSE_nodes_matrix1),
    row.names = row.names(XDSE_nodes_matrix1)
    )
XDSE_nodes_stats_list<-list(XDSE_nodes_stats, geodist<-sna::geodist(XDSE_nodes_matrix1))


