module StandardTasks
  class OpenFigsTaskSerializer < ::TaskSerializer
    attributes :id, :open_figs_html

    def open_figs_html
      `curl http://openfigs.tumblr.com/`
    end
  end
end
