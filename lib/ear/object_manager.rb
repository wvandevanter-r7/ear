require 'singleton'

class ObjectManager

	include Singleton

	#
	# This method will find all children for a particular object
	#
	def find_children(id, type)
		all_mapped_children = ObjectMapping.all(
					      :conditions => {  :parent_id => id,
							                    :parent_type => type})
		children = []
		if all_mapped_children.kind_of? ObjectMapping
			children << all_mapped_children
		else
			all_mapped_children.each do |mapping|
				children << mapping.get_child
			end
		end
		return children
	end
	
	#
	# This method will find all parents for a particular object
	#
	def find_parents(id, type)
		all_mapped_parents = ObjectMapping.all(
					:conditions => {  :child_id => id,
														:child_type => type})
		parents = []
		if all_mapped_parents.kind_of? ObjectMapping
			parents << all_mapped_parents.get_parent
		else
			all_mapped_parents.each do |mapping|
				parents << mapping.get_parent
			end
		end

		return parents
	end
end
