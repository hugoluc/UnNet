import whois
import socket 

traceroute = open("./ufmg_01.txt")


count = 0

for lines in traceroute:
    count = count + 1
    start = lines.find("(")
    end = lines.find(")")
    if start > 0:
        ip = lines[start+1:end]
        whoisInfo = whois.whois(ip)
        print (str(count) + "----------------------ip number: " + str(ip))
        print(socket.gethostbyaddr(str(ip)))

   
        emailsCount = len(whoisInfo.emails)      

        if emailsCount > 0:
            for emails in whoisInfo.emails:
                start = emails.find("@")
                print (emails[start+1:])



