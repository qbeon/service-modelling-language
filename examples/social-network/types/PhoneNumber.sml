use {
	"std/regexp" 1.0
}

# PhoneNumber represents an international generic phone number
type socialNetwork::PhoneNumber = Array<Byte>

new -> ?Error = match {
	!regexp::match(
		this,
		/\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$/,
	) then Error(`invalid phone number ($(this))`)
}
