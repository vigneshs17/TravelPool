namespace :pools do
  desc "Delete a pool when it has elapsed"
  task delete_when_over: :environment do
    Pool.where("be_there_at <= ?", Time.now).each do |pool|
      pool.destroy
    end
  end
end
