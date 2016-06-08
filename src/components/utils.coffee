classArray = (o)->
	return o if Array.isArray o
	return (k for k,v of o when v)

module.exports = {
	cx: (o)->
		p = classArray o
		p.join ' '

	scx: (s, o)->
		p = classArray o
		q = (s[k] for k in p)
		q.join ' '
}
