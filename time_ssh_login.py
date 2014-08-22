#!/usr/bin/python

import pexpect
import sys
import time

EXPECT_YESNO    = "\(yes/no\)\? "

def connect(ipaddr,user,password):
	print("Connecting to %s" % ipaddr)
	child = pexpect.spawn('ssh %s@%s' % (user,ipaddr))
	child.logfile_read = sys.stdout
	index = child.expect(['password: ',EXPECT_YESNO])
	if index == 1:
		print("Automatically accepting hostkey.")
		child.sendline('yes')
		child.expect('password')
	child.sendline(password)
	child.expect('~\$ ')
	child.sendline('id')
	child.expect('~\$ ')
	child.sendline('exit')
	child.expect('closed.')
	
def main():
	start = time.time()
	print("This is main")
	connect(sys.argv[1],sys.argv[2],sys.argv[3])
	end = time.time()
	result = end - start
	print("It took %s seconds" % result)

if __name__ == '__main__':
	if (len(sys.argv) != 4):
		print("Syntax: %s IPAddress username password" % sys.argv[0])
		exit(2)
	main()
