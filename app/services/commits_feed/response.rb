module CommitsFeed
  class Response
    def initialize(commits)
      @commits = JSON.parse(commits)
    end

    def parse
      commits.map do |commit_data|
        Commit.new.tap do |commit|
          commit.sha = commit_data['sha']
          commit.url = commit_data['html_url']
          set_commit_info(commit, commit_data['commit'], commit_data['parents'])
          set_author(commit, commit_data['author'])
          set_committer(commit, commit_data['committer'])
        end
      end
    end

    private

    attr_reader :commits

    def set_commit_info(commit, commit_info, parents)
      commit.message = commit_info&.dig('message')
      commit.committer_date = commit_info&.dig('committer', 'date')
      commit.verified = commit_info&.dig('verification', 'verified')
      commit.parents_sha = parents.map { |parent| parent['sha'] }
    end

    def set_author(commit, author_data)
      commit.author = author_data&.dig('login')
      commit.author_url = author_data&.dig('html_url')
    end

    def set_committer(commit, committer_data)
      commit.committer = committer_data&.dig('login')
      commit.committer_url = committer_data&.dig('html_url')
    end
  end
end
