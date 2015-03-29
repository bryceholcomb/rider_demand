namespace :data do
  desc "Update time estimates from Uber endpoint"
  task time_estimates: :environment do
    TimeEstimateBuilder.new.build_estimates

    puts "
  end
end
