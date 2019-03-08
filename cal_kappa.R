library(clue)
library(irr)

cal_kappa = function(clusteringA, clusteringB) {
# clusteringA: true labels
# clusteringB: computed labels
# cal_kappa: kappa of clusteringA versus clusteringB
    
  idsA = unique(clusteringA)  
  idsB = unique(clusteringB)  
  nA = length(clusteringA)  
  
  nC1 = length(idsA)
  nC2 = length(idsB)
  tupel1 = c(1:nA)
  tupel2 = c(1:nA)
  
  assignmentMatrix = matrix(rep(0, nC2 * nC1), nrow = nC2)
  for (iter in 1:nC1) {
    tupelClusterI = tupel1[clusteringA == iter]
    solRowI = sapply(1:nC2, function(i, clusteringB, tupelClusterI) {
      nA_I = length(tupelClusterI)  # number of elements in cluster I
      tupelB_I = tupel2[clusteringB == i]
      nB_I = length(tupelB_I)
      nTupelIntersect = length(intersect(tupelClusterI, tupelB_I))
      return((nA_I - nTupelIntersect) + (nB_I - nTupelIntersect))
    }, clusteringB, tupelClusterI)
    assignmentMatrix[, iter] = solRowI
  }
  
  if (nC2 > nC1) {
    tmp = matrix(0, nrow = nC2, ncol = (nC2 - nC1)) 
    assignmentMatrix = cbind(assignmentMatrix, tmp)
  }
  else if (nC2 < nC1) {
    tmp = matrix(0, ncol = nC1, nrow = (nC1 - nC2)) 
    assignmentMatrix = rbind(assignmentMatrix, tmp)
  }
  
  # optimization
  map_result = solve_LSAP(assignmentMatrix)
  
  new_label = clusteringB
  for(groups in 1:length(map_result)){
    new_label[which(clusteringB == groups)] = map_result[groups]
  }
  
  data = data.frame(clusteringA, new_label)
  kappa = kappa2(data)$value 
  return(kappa)
}
