# load the igraph and rgexf packages
library(igraph)
library(rgexf)

#Read in data - longform two columns expected
cmbd<- read.csv("cmbd2.csv")

#convert df to matrix
dat.imports<- data.matrix(cmbd, rownames.force=NA)

#create the graph
g <- graph.edgelist(dat.imports)
g <- decompose.graph(g)
g <- g[[which(sapply(g, vcount) == max(sapply(g, vcount)))]]

# construct the nodes and edges data for gexf conversion
nodes <- data.frame(cbind(V(g), as.character(V(g))))
edges <- t(Vectorize(get.edge, vectorize.args='id')(g, 1:ecount(g)))

#Write the gexf file
write.gexf(output='test4.gexf',nodes=nodes,edges=edges,
defaultedgetype = "undirected")

##Next step is to load gexf file into Gephi and customize network
