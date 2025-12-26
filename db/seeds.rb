# frozen_string_literal: true

# Clear existing data
puts '🗑️  Clearing existing data...'
PasswordAttachment.delete_all
Password.delete_all
User.delete_all
Gender.delete_all
UserType.delete_all

# Create Genders
puts '👥 Creating genders...'
genders = [
  { name: 'Male', alias: 'male' },
  { name: 'Female', alias: 'female' },
  { name: 'Other', alias: 'other' },
  { name: 'Prefer not to say', alias: 'prefer_not_to_say' }
]

genders.each do |gender_data|
  Gender.create!(gender_data)
end
puts "✅ Created #{Gender.count} genders"

# Create User Types
puts '🏷️  Creating user types...'
user_types = [
  { name: 'Administrator', alias: 'administrator' },
  { name: 'User', alias: 'user' },
  { name: 'Manager', alias: 'manager' },
  { name: 'Guest', alias: 'guest' }
]

user_types.each do |type_data|
  UserType.create!(type_data)
end
puts "✅ Created #{UserType.count} user types"

# Get references
admin_type = UserType.find_by(alias: 'administrator')
user_type = UserType.find_by(alias: 'user')
manager_type = UserType.find_by(alias: 'manager')
male_gender = Gender.find_by(alias: 'male')
female_gender = Gender.find_by(alias: 'female')

# Create Admin User
puts '👨‍💼 Creating admin user...'
admin = User.create!(
  email: 'admin@passwordmanager.com',
  password: 'Admin@123',
  password_confirmation: 'Admin@123',
  first_name: 'Admin',
  last_name: 'User',
  phone: '+1-555-0100',
  gender: male_gender,
  user_type: admin_type,
  active: true
)
puts "✅ Created admin: #{admin.email}"

# Create Sample Users
puts '👥 Creating sample users...'
sample_users = [
  {
    email: 'john.doe@example.com',
    password: 'Password@123',
    first_name: 'John',
    last_name: 'Doe',
    phone: '+1-555-0101',
    gender: male_gender,
    user_type: user_type
  },
  {
    email: 'jane.smith@example.com',
    password: 'Password@123',
    first_name: 'Jane',
    last_name: 'Smith',
    phone: '+1-555-0102',
    gender: female_gender,
    user_type: user_type
  },
  {
    email: 'robert.johnson@example.com',
    password: 'Password@123',
    first_name: 'Robert',
    last_name: 'Johnson',
    phone: '+1-555-0103',
    gender: male_gender,
    user_type: manager_type
  },
  {
    email: 'emily.williams@example.com',
    password: 'Password@123',
    first_name: 'Emily',
    last_name: 'Williams',
    phone: '+1-555-0104',
    gender: female_gender,
    user_type: user_type
  },
  {
    email: 'michael.brown@example.com',
    password: 'Password@123',
    first_name: 'Michael',
    last_name: 'Brown',
    phone: '+1-555-0105',
    gender: male_gender,
    user_type: user_type
  },
  {
    email: 'sarah.davis@example.com',
    password: 'Password@123',
    first_name: 'Sarah',
    last_name: 'Davis',
    phone: '+1-555-0106',
    gender: female_gender,
    user_type: manager_type
  },
  {
    email: 'david.miller@example.com',
    password: 'Password@123',
    first_name: 'David',
    last_name: 'Miller',
    phone: '+1-555-0107',
    gender: male_gender,
    user_type: user_type
  },
  {
    email: 'lisa.wilson@example.com',
    password: 'Password@123',
    first_name: 'Lisa',
    last_name: 'Wilson',
    phone: '+1-555-0108',
    gender: female_gender,
    user_type: user_type
  }
]

users = sample_users.map do |user_data|
  User.create!(user_data.merge(active: true))
end
puts "✅ Created #{users.count} sample users"

# Create Sample Passwords
puts '🔐 Creating sample passwords...'
all_users = User.all

password_data = [
  {
    name: 'GitHub Account',
    url: 'https://github.com',
    username: 'john.doe',
    email: 'john.doe@example.com',
    text_password: 'GithubSecure@2024',
    details: 'Personal GitHub account for development projects',
    active: true
  },
  {
    name: 'AWS Console',
    url: 'https://console.aws.amazon.com',
    username: 'aws-admin',
    email: 'admin@company.com',
    text_password: 'AwsC0ns0le!2024',
    key: 'AKIAIOSFODNN7EXAMPLE',
    details: 'AWS Management Console access for production environment',
    active: true
  },
  {
    name: 'Database Production',
    url: 'postgresql://prod-db.example.com:5432',
    username: 'db_admin',
    email: 'dba@company.com',
    text_password: 'DbPr0d@2024!Secure',
    details: 'Production PostgreSQL database credentials',
    active: true
  },
  {
    name: 'Slack Workspace',
    url: 'https://company-workspace.slack.com',
    username: 'jane.smith',
    email: 'jane.smith@example.com',
    text_password: 'SlackT3am@2024',
    details: 'Company Slack workspace for team communication',
    active: true
  },
  {
    name: 'Heroku Dashboard',
    url: 'https://dashboard.heroku.com',
    username: 'heroku-deployer',
    email: 'deploy@company.com',
    text_password: 'H3r0ku!Deploy2024',
    key: 'heroku-api-key-example-123456',
    details: 'Heroku platform access for application deployment',
    active: true
  },
  {
    name: 'Stripe API',
    url: 'https://dashboard.stripe.com',
    username: 'payments@company.com',
    email: 'payments@company.com',
    text_password: 'Str1p3Pay@2024!',
    key: 'sk_live_example_key_123456789',
    details: 'Stripe payment gateway API credentials',
    active: true
  },
  {
    name: 'Google Cloud Platform',
    url: 'https://console.cloud.google.com',
    username: 'gcp-admin',
    email: 'cloud@company.com',
    text_password: 'GcpCl0ud!2024Secure',
    details: 'GCP console access for cloud infrastructure management',
    active: true
  },
  {
    name: 'Docker Hub',
    url: 'https://hub.docker.com',
    username: 'dockeruser',
    email: 'docker@company.com',
    text_password: 'D0ck3rHub@2024',
    details: 'Docker Hub repository access for container images',
    active: true
  },
  {
    name: 'SSH Production Server',
    url: 'ssh://prod-server.example.com',
    username: 'sysadmin',
    email: 'sysadmin@company.com',
    text_password: 'SshPr0d@2024!Server',
    ssh_finger_print: 'SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8',
    ssh_public_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDExample sysadmin@company.com',
    ssh_private_key: '-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAExample...
-----END RSA PRIVATE KEY-----',
    details: 'SSH access to production application server',
    active: true
  },
  {
    name: 'Jira Project',
    url: 'https://company.atlassian.net',
    username: 'project.manager',
    email: 'pm@company.com',
    text_password: 'J1ra!Pr0ject2024',
    details: 'Jira project management and issue tracking',
    active: true
  },
  {
    name: 'Jenkins CI/CD',
    url: 'https://jenkins.company.com',
    username: 'jenkins-admin',
    email: 'cicd@company.com',
    text_password: 'J3nkins!CI2024',
    key: 'jenkins-api-token-example',
    details: 'Jenkins automation server for CI/CD pipeline',
    active: true
  },
  {
    name: 'MongoDB Atlas',
    url: 'https://cloud.mongodb.com',
    username: 'mongodb-admin',
    email: 'nosql@company.com',
    text_password: 'M0ng0DB@2024Atlas',
    details: 'MongoDB Atlas cloud database cluster access',
    active: true
  },
  {
    name: 'SendGrid Email API',
    url: 'https://app.sendgrid.com',
    username: 'email-service',
    email: 'noreply@company.com',
    text_password: 'S3ndGr1d@2024!',
    key: 'SG.example_api_key_123456789',
    details: 'SendGrid transactional email service API',
    active: false
  },
  {
    name: 'Redis Cache',
    url: 'redis://cache.example.com:6379',
    username: 'redis-user',
    email: 'cache@company.com',
    text_password: 'R3d1s!Cache2024',
    details: 'Redis in-memory cache server credentials',
    active: true
  },
  {
    name: 'Cloudflare Dashboard',
    url: 'https://dash.cloudflare.com',
    username: 'dns-admin',
    email: 'dns@company.com',
    text_password: 'Cl0udfl@re2024!',
    details: 'Cloudflare DNS and CDN management',
    active: true
  }
]

password_data.each_with_index do |pwd_data, index|
  user = all_users[index % all_users.count]
  Password.create!(pwd_data.merge(user: user))
end

puts "✅ Created #{Password.count} sample passwords"

# Summary
puts "\n" + "=" * 50
puts "🎉 Seed data creation completed!"
puts "=" * 50
puts "\n📊 Summary:"
puts "  • Genders: #{Gender.count}"
puts "  • User Types: #{UserType.count}"
puts "  • Users: #{User.count}"
puts "  • Passwords: #{Password.count}"
puts "\n🔑 Admin Credentials:"
puts "  • Email: admin@passwordmanager.com"
puts "  • Password: Admin@123"
puts "\n👤 Sample User Credentials:"
puts "  • Email: john.doe@example.com"
puts "  • Password: Password@123"
puts "=" * 50
