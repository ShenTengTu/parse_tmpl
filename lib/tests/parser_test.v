module main

import lib { parse_attr }

fn test_parse_attr() {
	name := 'view'

	mut text := 'vieq'
	mut attr := parse_attr(name, text)
	assert attr.name == ''
	assert attr.msg == ''

	text = 'view'
	attr = parse_attr(name, text)
	assert attr.name == 'view'
	assert attr.msg == ''

	text = 'view:'
	attr = parse_attr(name, text)
	assert attr.name == 'view'
	assert attr.msg == ''

	text = 'view: '
	attr = parse_attr(name, text)
	assert attr.name == 'view'
	assert attr.msg == ''

	text = 'view: other/path'
	attr = parse_attr(name, text)
	assert attr.name == 'view'
	assert attr.msg == 'other/path'
}
