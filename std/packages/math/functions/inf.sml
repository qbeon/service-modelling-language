# inf equals positive infinity if $sign >= 0,
# negative infinity if $sign < 0.
function math::inf

parameters {
	$sign Int32
}

// Implementation is provided by the implementing engine
value Float64
