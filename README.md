# tf-module-vpc
1. Created the VPC
2. created the 2 subnets(good to maintain 2 always if 1 not worked other will be safer side) in above vpc.
3. created the peering connection
******
Created a server using above vpc and subnet and verified the connection using ssh

But still unable to connect because it need route table conection.
4. created the route table for the default_vpc and newly created vpc
****
Now we are able to connect the server but there is no internet connection