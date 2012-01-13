class RunnableTaskQueue

  include Enumerable

  def initialize
    @runnable_tasks = []
  end

  def each(&block)
    @runnable_tasks.each do |task|
      block.call(task)
    end
  end

  def add_task_run(object, task, options)
    @runnable_tasks << [object, task, options]
  end

  def has_tasks?
    !@runnable_tasks.empty?
  end

  def shift
    @runnable_tasks.shift
  end

  def pop
    @runnable_tasks.pop
  end

end
