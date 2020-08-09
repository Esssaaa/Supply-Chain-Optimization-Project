rm(list=ls())
# Name: Yiran Sun

require(igraph)

origin <- seq(1,8,1)
f <- c(1,1,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7)
t <- c(2,3,5,4,4,6,7,5,7,3,8,6,2,7,5,8,8,6)
w <- c(20,15,15,10,13,15,10,10,12,13,10,7,15,8,7,8,10,8)
arcs <- cbind(f,t,w)

newGraph <- graph_from_edgelist(arcs[,1:2],directed=T)
E(newGraph)$capacity <- arcs[,3]
maxflow1 <- max_flow(newGraph,source = 1, target=8)$value
maxflow1

maxflow2<-c()
for (k in 1:10){
  f <- c(1,1,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7)
  t <- c(2,3,5,4,4,6,7,5,7,3,8,6,2,7,5,8,8,6)
  w <- c(20*k,15*k,15,10,13,15,10,10,12,13,10*k,7,15,8,7,8*k,10*k,8)
  arcs <- cbind(f,t,w)
  
  newGraph <- graph_from_edgelist(arcs[,1:2],directed=T)
  E(newGraph)$capacity <- arcs[,3]
  maxflow2[k]<-max_flow(newGraph,source = 1, target=8)$value
}
maxflow2
# According to maxflow2, when factor k = 3, the flow reaches to its maximum capacity, which is 62, 
# and it stays the same as k increases.