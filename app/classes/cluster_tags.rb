# frozen_string_literal: true

class ClusterTags
  CATEGORIES = {
    "xxl" => 5_000..1_000_000,
    "xl"  => 1_000..5_000,
    "lg"  => 500..1_000,
    "md"  => 100..500,
    "sm"  => 50..100,
  }.freeze

 INVERTED_CATEGORIES = CATEGORIES.invert.freeze
 DEFAULT_CATEGORY = "xs"

  class << self
    def call
      new.call
    end

    def each_category(&block)
      (CATEGORIES.keys + DEFAULT_CATEGORY).each(&block)
    end
  end

  def call
    cluster_tags
  end

  private

  def cluster
    @cluster ||= ApplicationRecord.connection.execute(cluster_sql).to_a
  end

  def cluster_tags
    cluster
      .group_by { |tag| category(tag["frequency"]) }
      .transform_values { |tags| tags.sort_by { |tag| -tag["frequency"] } }
  end

  def category(number)
    INVERTED_CATEGORIES
      .detect { |(range, value)| range.cover?(number.to_i) }
      .to_a
      .last || DEFAULT_CATEGORY
  end

  def cluster_sql
    <<~SQL
      select word, count(word) as frequency
      from(
        select(unnest(tags)) as word from books
      ) words
      group by word
      order by frequency desc
    SQL
  end
end

