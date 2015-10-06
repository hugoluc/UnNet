import pandas as pd

csvFile = pd.read_csv("out.csv", low_memory=False)

site_names = ["www.ufmg.br","www.stackoverflow.com","www.facebook.com","processing.org"]

vizData = pd.DataFrame(columns = ["site","njumps","org3","orgpos","coun3","counpos"])


#----------------------------

# find avarage N of jumps

dvizCount = 0

for i  in range(0,len(site_names)): 
 
  
    siteData = csvFile[[x == site_names[i] for x in csvFile.website]]


    print "\n",site_names[i]

    #grav avagare n of jumps for each website
    nOfNala = len(siteData[[x == 1 for x in siteData.jumpN]])
    njumps = sum(siteData.sort("jumpN")["jumpN"][-nOfNala:])/nOfNala
    print "avarage jumps:------------>",njumps

#----------------------------

    #grab top all orgs counts
    count = 0 
    topNames = []    
    top3Names = []      
    orgNames = pd.DataFrame(columns = ["name","count"])

    for Name in set(siteData["orgName"]):
        
        count = count + 1 
        # all orgs counts
        orgNames.loc[count] = [Name, len(siteData[[x == Name for x in siteData.orgName]])]
        
    # 3 top orgs            
    topNames = orgNames.sort(columns = ["count"], ascending = [False])["name"]

    top3Names = []    

    for item in topNames:
        if item != "Verizon Online LLC":
            if len(topNames) <= 3:
                 top3Names.append(item)
            elif item != "*":
                top3Names.append(item)
    
    topNames = top3Names[:3]    

    #get avarege position for each org
    count = 0  
    orgNames = pd.DataFrame(columns = ["name","count"])    
    for names in topNames:
        
        count = count + 1
        jumpData = siteData[[x == names for x in siteData.orgName]]["jumpN"]
        orgNames.loc[count] = [names, sum(jumpData)/len(jumpData)]

#----------------------------


    #grab top all country counts
    count = 0 
    topCountryNames = []
    top3Names = []     
    countCountryNames = pd.DataFrame(columns = ["name","count"])

    for Name in set(siteData["country"]):
        
        count = count + 1
        # all country counts
        countCountryNames.loc[count] = [Name, len(siteData[[x == Name for x in siteData.country]])]
   
    # 3 top countries
    topCountryNames = countCountryNames.sort(columns = ["count"], ascending = [False])["name"]

    for item in topCountryNames:

        print(len(item))
        if(item == "*"):
            print("name too big adding * instead")
        else:
            if len(item) < 4:
                top3Names.append(item)
    
    while len(top3Names) < 3:
        top3Names.append("*")


    topNames = top3Names[:3]    


    #get avarege position for each country
    count = 0  
    countCountryNames = pd.DataFrame(columns = ["name","count"])
    for Cnames in topNames:

        count = count +1  
        jumpData = siteData[[x == Cnames for x in siteData.country]]["jumpN"]
        countCountryNames.loc[count] = [Cnames,sum(jumpData)/len(jumpData)]

#----------------------------
    count = 0
    for l in range(0,len(countCountryNames)):
        count = count + 1
        dvizCount  = dvizCount  + 1

        orgName =  orgNames.iloc[l]["name"]
        orgCount = orgNames.iloc[l]["count"]
        couName = countCountryNames.iloc[l]["name"]
        couCount = countCountryNames.iloc[l]["count"]        
        
        vizData.loc[dvizCount] = [site_names[i],njumps,orgName,orgCount,couName,couCount]

vizData.to_csv("../Processing/Data/vizData.csv" ,header=True)


