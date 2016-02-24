killport(){

	if [ -z "$1" ]; then
		echo "Usage: searchAndDestroy [numeric port identifier]" >&2
		return 1
	fi
	lsof -i TCP:$1 | awk '/LISTEN/{print $2}' | xargs kill -9

}