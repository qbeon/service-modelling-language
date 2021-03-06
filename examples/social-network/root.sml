use {
	"std"      1.0
	"std/time" 1.0
	"std/math" 1.0
}

root SocialNetwork {
	# trendingPublicPosts lists all currently trending public posts sorted by
	# the number of reactions
	trendingPublicPosts collection<Post>(
		($p) => $p.access == Visibility::public and
			$p.archived == nil and
			$p.publication >= time::add(now(), Day(7)),
		Order::desc,
		Post.reactions:length,
	)

	admins collection<Admin>

	adminActivities collection<AdminActivity>(
		order   = Order::desc,
		orderBy = AdminActivity.time,
	)

	users collection<User>

	countries collection<Country>

	cities collection<City>

	organizations collection<Organization>

	reactions collection<Reaction>

	posts collection<Post>

	# mutualFriends lists all mutual friends between the given users
	mutualFriends (
		$target ID<User>
		$friend ID<User>
	) Array<User> = intersection($target.friends, $friend.friends)
}

access {
	allow anyone
}

access trendingPublicPosts {
	allow anyone
}

# Allow only admins
access reactions {
	allow Admin
}

# Allow users to find mutual friends between themselves and their friends only
access mutualFriends as $mf {
	allow Admin
	allow User as $accessor if $accessor == $mf.$target and
		$mf.$target in $mf.$friend.friends
}
