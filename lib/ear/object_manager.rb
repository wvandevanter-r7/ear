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
    #
    # Here, we check to see if we just have a single object mapping
    #
    if all_mapped_children.kind_of? ObjectMapping
      children << all_mapped_children
    else
      #
      # Because we have to account for missing parents, this is 
      # pretty careful about what get returns from this function
      #
      all_mapped_children.each do |mapping|
        child = mapping.get_child
        children << child if child
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
    #
    # Here, we check to see if we just have a single object mapping
    #
    if all_mapped_parents.kind_of? ObjectMapping
      parents << all_mapped_parents.get_parent
    else
      #
      # Because we have to account for missing parents, this is 
      # pretty careful about what get returns from this function
      #
      all_mapped_parents.each do |mapping|
        parent = mapping.get_parent
        parents << parent if parent 
      end
    end
  parents
  end
  
  #
  # This function is much the same as the find_parents and find_children functions
  #
  def find_task_runs(id, type)
      all_mapped_parents = ObjectMapping.all(
          :conditions => {  :child_id => id,
                            :child_type => type})
    task_runs = []
    if all_mapped_parents.kind_of? ObjectMapping
      task_runs << all_mapped_parents.get_task_run
    else
      all_mapped_parents.each do |mapping|
        task_run = mapping.get_task_run
        task_runs << task_run if task_run
      end
    end
  task_runs
  end
  
end
