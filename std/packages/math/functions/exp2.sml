# exp2 equals 2 ** $x, the base-2 exponential of $x
function math::exp2

use {
	"std" 1.0
}

parameters {
	$x Float64
}

// Implementation is provided by the implementing engine
value Float64