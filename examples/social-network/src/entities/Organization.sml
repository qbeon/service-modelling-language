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

	posts Posts {
		publisher: this
	}

	ratings Collection<OrganizationRating> {
		predicate: ($or) => $or.organization == this
		order:     Order::desc
		orderBy:   OrganizationRating.publication
	}

	# parentOrganization links the parent organization if this organization
	# is a subsidiary
	parentOrganization ?Organization
	
	# subsidiaries links any subsidiary organizations
	subsidiaries Collection<Organization> {
		predicate: ($o) => $o.parentOrganization
	}

	# employments links all present and past employments
	employments Collection<Employment> {
		predicate: ($e) => $e.organization == this
		order:     Order::asc
		orderBy:   Employment.start
	}

	# presentEmployments links all current employments
	presentEmployments Collection<Employment> {
		predicate: ($e) => $e.organization == this && $e.end == nil
		order:     Order::asc
		orderBy:   Employment.start
	}

	# pageAdmins lists all page administrators
	pageAdmins Array<User>
}

access {
	# An organization is publicly accessible
	allow anyone
}

# The list of page administrators is only accessible to page administrators
access pageAdmins {
	allow Admin
	allow User as $accessor if $accessor in this.pageAdmins
}

# All post nodes except the published and trending ones are only be accessible
# to the organization's page administrators
access posts.all {
	allow Admin
	allow User as $accessor if $accessor in this.pageAdmins
}

access posts.archived {
	allow Admin
	allow User as $accessor if $accessor in this.pageAdmins
}

access posts.published {
	allow anyone
}

access posts.trending {
	allow anyone
}
