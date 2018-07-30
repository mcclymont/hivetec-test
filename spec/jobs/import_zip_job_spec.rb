require 'rails_helper'

RSpec.describe ImportZipJob, type: :job do
  include ActiveJob::TestHelper

  let(:zip_path) { Rails.root.join 'spec', 'fixtures', 'files', 'csv', 'empty.zip' }
  let(:import) { Import.create! zip_filepath: zip_path }

  ActiveJob::Base.queue_adapter = :test

  it 'queues the job when import is created' do
    expect { import }.to have_enqueued_job(described_class).on_queue('default')
    expect(ActiveJob::Base.queue_adapter.enqueued_jobs[0][:args]).to eq [import.id]
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
