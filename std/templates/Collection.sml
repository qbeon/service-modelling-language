# Collection represents a paginable collection of entities
template std::Collection<@T>

attributes {
	*predicate ?(@T) => Bool |> match { $ == nil = ($x) => true }
	*order     ?Order
	*orderBy   ?(Selector<@T> or Array<Selector<@T>>)
}

parameters {
	$page (Array<ID<@T>> or struct {
		cursor ID<@T>
		limit  @L
	})
}

value struct {
	totalLength Uint64 = collectionLength<@T>()
	version     Version = collectionVersion<@T>()

	items Array<@T> = typeof $page as $p {
		Array<ID<@T>> = fetch<@T>(
			($t) => $t:id in $p and *predicate($t),
			*order,
			*orderBy,
			$limit
		)
		struct {
			cursor ID<@T>
			limit  Int32
		} = match {
			$p.limit > 0 = fetch<@T>(
				($t) => $t:id > $p.cursor and *predicate($t),
				*order,
				*orderBy,
				$limit,
			)
			$p.limit < 0 = fetch<@T>(
				($t) => $t:id < $p.cursor and *predicate($t),
				*order,
				*orderBy,
				$limit,
			)
		}
		default = []
	}
}

constraints {
	require @T entity
	require @L integer
}