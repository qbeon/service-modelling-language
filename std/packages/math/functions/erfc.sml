# erfc equals the complementary error function of $x
function math::erfc ($x @N)

// Implementation is provided by the implementing engine
value @N

constraints {
	require @N numeric
}
