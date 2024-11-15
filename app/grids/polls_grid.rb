class PollsGrid
  include Datagrid

  scope do
    Poll.includes(:options).page
  end

  filter(:question, :string) { |value| where("question LIKE ?", "%#{value}%") }

  column(:question)
  column(:created_at) do |record|
    record.created_at.to_date.to_s(:db)
  end
  column(:options, html: true) do |record|
    record.options.map(&:content).join(", ")
  end
  column(:votes, html: true) do |record|
    record.options.sum(&:vote_count)
  end
end
