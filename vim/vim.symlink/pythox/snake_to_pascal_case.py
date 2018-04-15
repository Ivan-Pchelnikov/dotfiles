def snake_to_pascal_case(str, delim = '-'):
	pascal_str = ''
	for w in str.split(delim):
		pascal_str += w[0].upper() + ''.join(w[1:])
	return pascal_str

