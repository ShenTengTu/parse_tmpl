module lib

import regex { regex_opt }

// a Struct representing  an V attribute
struct Attr {
pub:
	name string
	msg  string
}

// Parse specific V attribute text to `Attr` struct.
// The argument `name` specifys an attribute name,
// The argument `txt` is the attribute text to be parsed.
// Return `Attr` struct containing empty fields  if the text isn't a valid attribute.
pub fn parse_attr(name string, txt string) Attr {
	// Uses regex to parse the text
	q := '^(?P<name>$name)(?::\\s(?P<msg>.+))?'
	mut re := regex_opt(q) or { panic(err) }
	start, _ := re.match_string(txt)

	mut attr := Attr{}
	if start < 0 { // if not match
		return attr
	}
	// Assigns fields
	mut s, mut e := 0, 0
	$for f in Attr.fields {
		$if f.typ is string {
			s, e = re.get_group_bounds_by_name(f.name)
			if s >= 0 {
				attr.$(f.name) = txt.substr(s, e)
			}
		}
	}
	return attr
}
