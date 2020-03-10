
 
package Apache::Ocsinventory::Plugins::Anydesk::Map;
 
use strict;
 
use Apache::Ocsinventory::Map;

$DATA_MAP{anydesk} = {
		mask => 0,
		multi => 1,
		auto => 1,
		delOnReplace => 1,
		sortBy => 'ADID',
		writeDiff => 0,
		cache => 0,
		fields => {
                ADID => {},
                VERSION => {}
	}
};
1;