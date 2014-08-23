#!/bin/bash
#
# Author: Niklas Andersson <niklas.andersson@openforce.se>
#
# Syntax: tshark_debug.sh IPAddress username password
#
#
# Our output file in pcap format
#
OUTPUT_FILE=/tmp/debug$$.pcap
#
# Basic error checking. Not fool proof.
#
if [ "$SUDO_USER" == "" ]; then
  echo "Error: You need to run the command with sudo"
  exit 2
fi

if [ "$#" != "3" ]; then
  echo "Syntax: $0 IPAddress username password"
  exit 2
fi
#
# Start up tshark network logging with a five seconds 
# grace period. If not we might not be ready to tap
# when the session starts.
#
tshark -i docker0 -w $OUTPUT_FILE &
sleep 5
#
# Do the login thing, feeding the process with our arguments.
#
./time_ssh_login.py $1 $2 $3
#
# Kill the tshark process. (kill last background process)
#
kill $!
#
# Fix the output file and feed it to Wireshark 
# with normal user privileges for analysis.
#
chmod 644 $OUTPUT_FILE
echo "Created $OUTPUT_FILE"
su $SUDO_USER -c "wireshark -r $OUTPUT_FILE"
