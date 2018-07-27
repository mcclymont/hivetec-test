class ImportZipJob < ApplicationJob
  queue_as :default

  def perform(import_id)
    import = Import.find(import_id)
    import.update!(status: 'processing')

    start_time = Time.current
    Import.transaction do
      ImportZipService.import!(import.zip_filepath, import.id)
      import.update!(status: 'done')
    end

    # Not inside the transaction block because committing the transaction
    # itself might take a significant amount of time
    import.update!(processing_time_seconds: Time.current - start_time)
  end
end
