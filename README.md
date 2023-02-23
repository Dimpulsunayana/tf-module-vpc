# tf-module-vpc
1. Created the VPC
2. created the 2 subnets(good to maintain 2 always if 1 not worked other will be safer side) in above vpc.
3. created the peering connection
(if nor peering conn,go for direct connect or VPN )
******
Created a server using above vpc and subnet and verified the connection using ssh

But still unable to connect because it need route table conection.
4. created the route table for the default_vpc and newly created vpc
****
Now we are able to connect the server but there is no internet connection

5. For an internet connection,We are gng to create IGW(Internet gateway)
Internet gateway will be created in vpc & subnet level

6. IGW is for public subnets and NAT GW is for private subnets

scope -- we r creating 2 public and 2 private subnets

created 2 public subnets and gave the IGW with the help of route_table
and now creating NAT GW in public subnets and by using this NAT GW,we will be creating 2 private subnets.
so that the servers will have only private ip.