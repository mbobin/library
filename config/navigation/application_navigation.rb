SimpleNavigation::Configuration.run do |navigation|
  navigation.renderer = SimpleNavigationBootstrap::Bootstrap4

  navigation.items do |primary|
    primary.dom_class = "mr-auto mt-2 mt-lg-0"
    options = { link_html: { class: "text-white nav-link" } }

    primary.item :library, 'Library', books_path, options

    primary.item :collections, 'Collections', collections_path,
      options.merge(if: -> { user_signed_in? })

    primary.item :import_logs, 'Import Logs', logs_path,
      options.merge(if: -> { user_signed_in? && policy(ImportLog).index? })
  end
end
