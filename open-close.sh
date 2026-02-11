#!/usr/bin/env bash

open() {
	echo "Total Args: $#"
	nohup $1 > log.txt 2>&1 & pid=$!
}

close() {
	echo "Processo: $pid"
	kill -s KILL $pid
}

open $1
sleep 2
echo "Seu programa sera fechado!" >&2
sleep 2
close $process

