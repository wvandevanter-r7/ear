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
  children
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

  parents
  end
  
  def find_task_runs(id, type)
      all_mapped_parents = ObjectMapping.all(
          :conditions => {  :child_id => id,
                            :child_type => type})
    task_runs = []
    if all_mapped_parents.kind_of? ObjectMapping
      task_runs << all_mapped_parents.get_task_run
    else
      all_mapped_parents.each do |mapping|
        task_runs << mapping.get_task_run
      end
    end

  task_runs
  end
  
end
