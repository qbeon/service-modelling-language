// Implementation is provided by the implementing engine

# ldexp equals the inverse of f.frexp.
# It equals $frac × 2 ** $exp.
function math::ldexp (
	$frac @N,
	$exp  @I,
) -> @N

constraints {
	require @N numeric
	require @I integer
}
