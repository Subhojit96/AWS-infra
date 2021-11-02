#Availablity-Zone
data "aws_availability_zones" "az" {} 

#VPC:A
resource "aws_vpc" "vpcA" {
  cidr_block = "${var.vpc_A_details}"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "${var.tag}-vpc-A"
  }
}

resource "aws_internet_gateway" "IGW2" {
  vpc_id = aws_vpc.vpcA.id
  tags = {
    "Name" = "${var.tag}-IGW"
  }
}
#subnets
resource "aws_subnet" "publicsubnet-A" {
  count= "${length(data.aws_availability_zones.az.names)}" 
  vpc_id = aws_vpc.vpcA.id
  cidr_block = "10.0.${0+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.az.names[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.tag}-env-PublicSubnet-A-${count.index}"
  }
}

resource "aws_subnet" "privatesubnet-A" {
  count= "${length(data.aws_availability_zones.az.names)}" 
  vpc_id = aws_vpc.vpcA.id
  cidr_block = "10.0.${10+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.az.names[count.index]}"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "${var.tag}-env-PrivateSubnet-A-${count.index}"
  }
}

resource "aws_route_table" "RT-A" {
  vpc_id = aws_vpc.vpcA.id
  route    {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IGW2.id}"
    }
  tags = {
    "Name" = "MainRouteTable-VPC-A"
  }
}

resource "aws_route_table_association" "rta-vpc-A" {
  count = "${length(resource.aws_subnet.publicsubnet-A)}"
  subnet_id = "${element(aws_subnet.publicsubnet-A.*.id,count.index)}"
  route_table_id = aws_route_table.RT-A.id
}

######################################   VPC: B    #############################################################
resource "aws_vpc" "vpcB" {
  cidr_block = "${var.vpc_B_details}"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "${var.tag}-vpc-B"
  }
}

resource "aws_subnet" "publicsubnet-B" {
  count= "${length(data.aws_availability_zones.az.names)}" 
  vpc_id = aws_vpc.vpcB.id
  cidr_block = "192.168.${0+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.az.names[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.tag}-env-PublicSubnet-B-${count.index}"
  }
}

resource "aws_subnet" "privatesubnet-B" {
  count= "${length(data.aws_availability_zones.az.names)}" 
  vpc_id = aws_vpc.vpcB.id
  cidr_block = "192.168.${10+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.az.names[count.index]}"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "${var.tag}-env-PrivateSubnet-B-${count.index}"
  }
}
resource "aws_route_table" "RT-B" {
  vpc_id = aws_vpc.vpcB.id
  tags = {
    "Name" = "MainRouteTable-VPC-A"
  }
}
resource "aws_route_table_association" "rta-vpc-B" {
  count = "${length(resource.aws_subnet.publicsubnet-B)}"
  subnet_id = "${element(aws_subnet.publicsubnet-B.*.id,count.index)}"
  route_table_id = aws_route_table.RT-B.id
}

############################          Peering          ###############################
resource "aws_vpc_peering_connection" "peering" {
  vpc_id = aws_vpc.vpcA.id
  peer_vpc_id = aws_vpc.vpcB.id
  auto_accept = true
  tags = {
    "Name" = "VPC Peering between VPC_A to VPC_B"
  }
}
resource "aws_vpc_peering_connection_options" "options" {
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id 
  accepter {
    allow_remote_vpc_dns_resolution = true
}
  requester {
    allow_classic_link_to_remote_vpc = true
    allow_vpc_to_remote_classic_link = true
  }
}

#adding Peered VPC routes to RouteTables
resource "aws_route" "routeA" {
  route_table_id = aws_route_table.RT-A.id
  destination_cidr_block = "${aws_vpc.vpcB.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peering.id}"
}
resource "aws_route" "routeB" {
  route_table_id = aws_route_table.RT-B.id
  destination_cidr_block = "${aws_vpc.vpcA.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peering.id}"
}