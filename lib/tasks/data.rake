namespace :data do
  desc "Update time estimates from Uber endpoint"
  task time_estimates: :environment do
    TimeEstimateBuilder.new.build_estimates

    puts "#{TimeEstimate.count} total time estimates"
  end
end
