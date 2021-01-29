t = read.csv('DESeqResultsTable_2.csv',row.names=1)

library(biomaRt)

mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl"))
G_list <- getBM(filters= "ensembl_gene_id", attributes= c("ensembl_gene_id","hgnc_symbol"),values=t$Gene,mart= mart)

t$hgnc_symbol = ""
t["hgnc_symbol"] = lapply("hgnc_symbol", function(x) G_list[[x]][match(t$Gene, G_list$ensembl_gene_id)])

write.table(t, "DESeqResultsTable_2.gene_symbol.csv")
