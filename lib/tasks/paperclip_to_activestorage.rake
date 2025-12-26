# lib/tasks/paperclip_to_activestorage.rake
namespace :paperclip do
  desc 'Migrate Paperclip attachments to ActiveStorage'
  task migrate: :environment do
    puts 'Starting migration from Paperclip to ActiveStorage...'

    # Migrate User avatars
    migrate_user_avatars

    # Migrate Password logos
    migrate_password_logos

    # Migrate PasswordAttachment files
    migrate_password_attachments

    # Migrate FileImport data files
    migrate_file_imports

    puts 'Migration complete!'
  end

  def migrate_user_avatars
    puts "\nMigrating User avatars..."
    User.find_each do |user|
      next if user.avatar.attached?
      next if user.avatar_file_name.blank?

      begin
        # Get the original file path
        path = user.avatar.path

        if File.exist?(path)
          # Attach to ActiveStorage
          user.avatar.attach(
            io: File.open(path),
            filename: user.avatar_file_name,
            content_type: user.avatar_content_type
          )
          puts "✓ Migrated avatar for User ##{user.id}"
        else
          puts "✗ File not found for User ##{user.id}: #{path}"
        end
      rescue StandardError => e
        puts "✗ Error migrating User ##{user.id}: #{e.message}"
      end
    end
  end

  def migrate_password_logos
    puts "\nMigrating Password logos..."
    Password.find_each do |password|
      next if password.logo.attached?
      next if password.logo_file_name.blank?

      begin
        path = password.logo.path

        if File.exist?(path)
          password.logo.attach(
            io: File.open(path),
            filename: password.logo_file_name,
            content_type: password.logo_content_type
          )
          puts "✓ Migrated logo for Password ##{password.id}"
        else
          puts "✗ File not found for Password ##{password.id}: #{path}"
        end
      rescue StandardError => e
        puts "✗ Error migrating Password ##{password.id}: #{e.message}"
      end
    end
  end

  def migrate_password_attachments
    puts "\nMigrating PasswordAttachment files..."
    PasswordAttachment.find_each do |pa|
      next if pa.attachment.attached?
      next if pa.attachment_file_name.blank?

      begin
        path = pa.attachment.path

        if File.exist?(path)
          pa.attachment.attach(
            io: File.open(path),
            filename: pa.attachment_file_name,
            content_type: pa.attachment_content_type
          )
          puts "✓ Migrated attachment for PasswordAttachment ##{pa.id}"
        else
          puts "✗ File not found for PasswordAttachment ##{pa.id}: #{path}"
        end
      rescue StandardError => e
        puts "✗ Error migrating PasswordAttachment ##{pa.id}: #{e.message}"
      end
    end
  end

  def migrate_file_imports
    puts "\nMigrating FileImport data files..."
    FileImport.find_each do |fi|
      next if fi.data.attached?
      next if fi.data_file_name.blank?

      begin
        path = fi.data.path

        if File.exist?(path)
          fi.data.attach(
            io: File.open(path),
            filename: fi.data_file_name,
            content_type: fi.data_content_type
          )
          puts "✓ Migrated data for FileImport ##{fi.id}"
        else
          puts "✗ File not found for FileImport ##{fi.id}: #{path}"
        end
      rescue StandardError => e
        puts "✗ Error migrating FileImport ##{fi.id}: #{e.message}"
      end
    end
  end
end
