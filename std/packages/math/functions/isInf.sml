// Implementation is provided by the implementing engine

# isInf equals true if $f is an infinity, according to $sign.
# If $sign > 0, isInf equals positive infinity.
# If $sign < 0, isInf equals negative infinity.
# If $sign == 0, isInf equals either infinity.
function math::isInf (
	$f    @N,
	$sign @I,
) -> Bool

constraints {
	require @N numeric
	require @I integer
}
