use {
	"std"      1.0
	"std/time" 1.0
}

entity socialNetwork::Post {
	publisher   (User or Organization)
	publication Time
	content     socialNetwork::Text
	access      VisibilityPermission

	reactions reactions(this)

	# archived specifies the time the post was removed. This field is nil when
	# the post was not removed
	archived ?Time
}

# Posts are either public, only accessible to the friends of a user, to a
# whitelist of friends or to all friends except the blacklisted ones
access {
	allow Admin
	allow User as $accessor if this.publisher as $publisher {
		User         = $accessor == $publisher
		Organization = true
		default      = false
	} or this.access as $access {
		Visibility = match $access {
			Visibility::public  = true
			Visibility::friends = $accessor in this.friends
		}
		VisibilityBlacklist = $accessor !in $access
		VisibilityWhitelist = $accessor in $access
	}
}
