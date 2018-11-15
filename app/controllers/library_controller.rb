class LibraryController < ApplicationController
  def index
    @cluster = ClusterTags.call
  end
end

