# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
require 'mime/types'
Mime::Type.register "application/epub+zip", :epub
Mime::Type.register "application/x-mobipocket-ebook", :azw
