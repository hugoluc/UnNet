import subprocess   
import pandas as pd

site_names = ["www.ufmg.br","www.stackoverflow.com","www.facebook.com"]
cmd_names = ["traceroute","whois"]

data = pd.DataFrame(columns=["jumpN","website","orgName","country"])

count = 0
jumpCount = 0

# execute all for every website
for i  in range(0,len(site_names)): 

    print(cmd_names[0],site_names[i])
    jumpCount = 0

    # run traceroute on website number "i"
    command = [cmd_names[0],site_names[i]]
    p = subprocess.Popen(command, universal_newlines=True, shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)


    # get every hop in traceroute lines
    for lines in iter(p.stdout.readline,''):

        lcount = 0
        hopN = 0
        for letters in lines:
            if lcount > 1:
                break
            hopN = letters
            lcount = lcount +1
        
        if(hopN != " "):

            
            count = count + 1
            jumpCount = jumpCount + 1
            print("---------------> jump n: ", jumpCount)



            print("line in traceroute: ", lines)

            start = lines.find("(")
            end = lines.find(")")   
            
            # if we have date on the router get that data
            if start > 0:

                ip = lines[start+1:end]

                # run who is on the ip address
                command = [cmd_names[1],ip]
                p = subprocess.Popen(command, universal_newlines=True, shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                
                whois = p.stdout.read()            

                # get name or organization owber of the router
                wStart = whois.find("OrgName:")+8
                wEnd = whois.find("\n", wStart)
                name = whois[wStart+8:wEnd]        


                # get country
                wStart = whois.find("Country:")+8
                wEnd = whois.find("\n", wStart)
                country = whois[wStart+8:wEnd]

                print("data: ", count,site_names[i],name,country,"\n")
                print("")


                data.loc[count] = [jumpCount,site_names[i],name,country]
            

            else:

                        
                data.loc[count] = [jumpCount,site_names[i],"NA","NA"]     
                      
                        
    
with open('out.csv', "a") as f:
    data.to_csv(f ,header=False)
