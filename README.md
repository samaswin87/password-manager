# Base Admin Panel

The base for administrative system, using Rails 4.2.3, PostgreSQL and AdminLTE theme. The i18n standardized for pt-BR.

### Installed features
- Devise (with invitable module)
- CanCanCan
- Inherited Resources
- Paperclip
- Sidekiq
- Simple Form
- Slim
- Squeel
- AdminLTE
- Bootstrap
- FontAwesome
- Simple Navigation
- Toastr
- Notify.js
- jQuery Mask
- SweetAlert
- LazyLoad (pictures)

### Use
After cloning the project, you must adjust:

- **CanCanCan**: Class Ability as needed, so far implemented for the `User` model
- **Devise**: Model `User` as required, db configured with devise for: `recoverable`, `trackable`, `lockable`, `invitable`
- **Theme**: Change the app / views / layouts / admin.html.erb file, replacing the color with blue, yellow, green, purple, red, black, with variations -light after the colors, ex: blue-light

## Roadmap
- [ ] Devise: Standardization in emails with templates and sensitive information
- [ ] Searchkick: Implement elasticsearch
