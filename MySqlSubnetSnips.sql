#Find the Smallest Subnet for two IP addresses.
#
#Outputs
# network	subnet	mask		broadcastAddress	rangeStart	rangeEnd	addresses
# 192.168.0.0	18	255.255.192.0	192.168.63.255		192.168.0.1	192.168.63.254	16382

SET @IP='192.168.4.0';
SET @IP2='192.168.62.254';
SET @CIDR= 32 - CEIL(LOG2(INET_ATON(@IP) ^ INET_ATON(@IP2)));
SELECT 
    INET_NTOA(INET_ATON(@IP) & CONV(CONCAT(REPEAT(1, @CIDR), REPEAT(0, 32 - @CIDR)), 2, 10)) AS network,
    @CIDR AS cidr,
    INET_NTOA(CONV(CONCAT(REPEAT(1, @CIDR), REPEAT(0, 32 - @CIDR)), 2, 10)) AS netmask,
    INET_NTOA((INET_ATON(@IP) | CONV(CONCAT(REPEAT(0, @CIDR), REPEAT(1, 32 - @CIDR)), 2, 10))) AS broadcastAddress,
    INET_NTOA((INET_ATON(@IP) & CONV(CONCAT(REPEAT(1, @CIDR), REPEAT(0, 32 - @CIDR)), 2, 10)) + 1) AS rangeStart,
    INET_NTOA((INET_ATON(@IP) | CONV(CONCAT(REPEAT(0, @CIDR), REPEAT(1, 32 - @CIDR)), 2, 10)) - 1) AS rangeEnd,
    (CONV(CONCAT(REPEAT(0, @CIDR), REPEAT(1, 32 - @CIDR)), 2, 10)) - 1 AS addresses
;


#Find the subnet details for an IP

SET @IP='172.31.20.250';
SET @CIDR='25';
SELECT 
	INET_NTOA(INET_ATON(@IP) & CONV(CONCAT(REPEAT(1, @CIDR), REPEAT(0, 32 - @CIDR)), 2, 10)) AS network,
	@CIDR AS cidr,
	INET_NTOA(CONV(CONCAT(REPEAT(1, @CIDR), REPEAT(0, 32 - @CIDR)), 2, 10)) AS netmask,
	INET_NTOA((INET_ATON(@IP) | CONV(CONCAT(REPEAT(0, @CIDR), REPEAT(1, 32 - @CIDR)), 2, 10))) AS broadcastAddress,
	INET_NTOA((INET_ATON(@IP) & CONV(CONCAT(REPEAT(1, @CIDR), REPEAT(0, 32 - @CIDR)), 2, 10)) +1) AS rangeStart,
	INET_NTOA((INET_ATON(@IP) | CONV(CONCAT(REPEAT(0, @CIDR), REPEAT(1, 32 - @CIDR)), 2, 10)) -1) AS rangeEnd,
	(CONV(CONCAT(REPEAT(0, @CIDR), REPEAT(1, 32 - @CIDR)), 2, 10)) -1 AS addresses
;

