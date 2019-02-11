# Organization represents a profile of an organization
entity SocialNetwork::Organization

use {
	"std" 1.0
}

properties {
	# id represents a configurable unique profile id
	id ?String

	name         Text
	description  Text
	registration Time
	type         OrganizationType
	phone        PhoneNumber
	address      Address
	website      URL
	contactEmail EmailAddress
	openingHours ?OrganizationOpeningHours
	imprint      Text
	posts        Posts
	ratings      <-> []OrganizationRating.organization

	# parentOrganization links the parent organization if this organization
	# is a subsidiary
	parentOrganization ?<-> Organization.subsidiaries
	
	# subsidiaries links any subsidiary organizations
	subsidiaries <-> []Organization.parentOrganization

	# employments links all present and past employments
	employments <-> []Employment.organization |>
		sort($, Order::Ascending, Employment.start)

	# presentEmployments links all current employments
	presentEmployments -> []Employment =
		filter(this.employments, ($e) => $e.end == nil)

	# pageAdmins lists all page administrators
	pageAdmins <-> []User.managedOrganizationPages
}

access {
	# An organization is publicly accessible
	allow public
}

# The list of page administrators is only accessible to page administrators
access pageAdmins {
	allow Admin
	allow User as $accessor if $accessor in this.pageAdmins
}

# All post nodes except the published and trending ones are only be accessible
# to the organization's page administrators
access posts {
	allow Admin
	allow User as $accessor if $accessor in this.pageAdmins
}

// TODO: update obsolete from syntax
access posts.published from Organization {
	allow public
}

// TODO: update obsolete from syntax
access posts.trending from Organization {
	allow public
}
