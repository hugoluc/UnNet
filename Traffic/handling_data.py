import pandas as pd

csvFile = pd.read_csv("UnNet-Package-01.csv", low_memory=False)

#-------------------------------------------------
#cauculte general info

avaragSize = sum(csvFile["Length"])/len(csvFile["Length"]) 
totalGbytes = avaragSize * max(csvFile["No."])

inbound = csvFile[[x == "172.16.245.123" for x in csvFile.Destination]]
outbound = csvFile[[x == "172.16.245.123" for x in csvFile.Source]] 

print "Total Packages: ", len(csvFile),
print "Avarage package size: ",avaragSize," bytes", "\n" 

print "Outbound total Packages: ",  len(outbound)
print "Outbound Avarage size: ",  sum(outbound["Length"])/len(outbound), " bytes"
print "Outbound total Gbytes: ",  sum(outbound["Length"])/1000000," MegaBytes", "\n"

print "Inbound total Packages: ",  len(inbound)
print "Inbound Avarage size: ", sum(inbound["Length"])/len(inbound), " bytes"
print "Inbound total Gbytes: ",  sum(inbound["Length"])/1000000, " MegaBytes"

print "\n"

#--------------------------------------------------------OUTBOUND
#-------------------------------------------------
#calculate frequency for every protocol

frequency = []

for protocol in set(outbound.Protocol):
   frequency.append([protocol,len(outbound[[x == protocol for x in outbound.Protocol]])])

print "Outbound------------------------------"
print"Packages Count"
FreSort = sorted(frequency, key=lambda x: x[1])
print FreSort[len(FreSort)-5:]


#-------------------------------------------------
#cauculte total legth doanloaded for each protocol

ProSize = []

for protocol in set(outbound.Protocol):
    ProSize.append([protocol,sum(outbound[[x == protocol for x in outbound.Protocol]]["Length"])/1000])

print "Size"
SizeSort = sorted(ProSize, key=lambda x: x[1])
print SizeSort[len(FreSort)-5:]

print "\n"

#--------------------------------------------------------INBOUND
#-------------------------------------------------
#calculate frequency for every protocol

frequency = []

for protocol in set(inbound.Protocol):
    frequency.append([protocol,len(inbound[[x == protocol for x in inbound.Protocol]])])


print "Inbound------------------------------"
print"Packages Count"
FreSort = sorted(frequency, key=lambda x: x[1])
print FreSort[len(FreSort)-5:]

#-------------------------------------------------
#cauculte total legth doanloaded for each protocol

ProSize = []

for protocol in set(inbound.Protocol):
    ProSize.append([protocol,sum(inbound[[x == protocol for x in inbound.Protocol]]["Length"])/1000])

print "size"
SizeSort = sorted(ProSize, key=lambda x: x[1])
print SizeSort[len(FreSort)-5:]
#-------------------------------------------------

