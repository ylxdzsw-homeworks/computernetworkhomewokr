module.exports = (wSize, now=0, base=0) ->
	back: (n=1) ->
		now -= n
		now += wSize if now < 0
		now
	go: (n=1) ->
		now += n
		now -= wSize if now >= wSize
		now
	next: () ->
		n = now + 1
		n -= wSize if n >= wSize
		n
	get: -> now
	set: (x) -> now = x
	gt: (x) ->
		x += wSize if x < base
		now > x
	minus: (x) ->
		n = now
		n += wSize if n < base
		n - x
	getbase: -> base
	rebase: (x) -> base = x