# RemovePost removes a published post
transaction SocialNetwork::RemovePost

use {
	"std" 1.0
}

parameters {
	$post ID<Post>
}

access RemovePost {
	# Only users are allowed to publish posts
	allow User as $accessor if select typeof($post.collection:entity) as $v {
		case User         = $accessor == $v
		case Organization = $accessor in $v.pageAdmins
	}
}
