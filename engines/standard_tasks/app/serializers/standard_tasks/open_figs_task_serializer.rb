module StandardTasks
  class OpenFigsTaskSerializer < ::TaskSerializer
    attributes :id, :open_figs_html

    def open_figs_html
      html = `curl http://openfigs.tumblr.com/`
      (2..10).each do |i|
        html += `curl http://openfigs.tumblr.com/page/#{i}`
      end
      html
    end
  end
end
