insecure_public_communication(Component_1, Component_2) :-
	property(Relation_ID, sensitivedata, true),
	relation_of_type(Relation_ID, connectsto),
	relation(Component_1, Component_2, Relation_ID),
	components_in_different_locations(Component_1, Component_2),
	not(property(Relation_ID, security, true)).

direct_access_to_restricted_environment(Component_1, Component_2) :-
	relation_of_type(Relation_ID, connectsto),
	relation(Component_1, Component_2, Relation_ID),
	components_in_different_locations(Component_1, Component_2),
	property(H, inboundcommunication, false),
	hosting_stack(S),
	member(Component_2, S),
	member(H, S).

distributed_messaging(Component, Channel) :-
    component_of_type(Channel, channel),
    direct_access_to_restricted_environment(Component, Channel).

components_in_different_locations(Component_1, Component_2) :-
	hosting_stack(S1),
	hosting_stack(S2),
	property(H1, location, Location_1),
	property(H2, location, Location_2),
	member(Component_1, S1),
	member(H1, S1),
	member(Component_2, S2),
	member(H2, S2),
	Location_1 \= Location_2.
