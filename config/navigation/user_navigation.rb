SimpleNavigation::Configuration.run do |navigation|
  navigation.renderer = SimpleNavigationBootstrap::Bootstrap4

  navigation.items do |primary|
    primary.item :logout, octicon('sign-out', fill: 'currentcolor', height: 24),
      destroy_user_session_path, method: :delete,
      if: -> { user_signed_in? },
      link_html: { class: "text-white nav-link pull-right" }

    primary.item :logout, octicon('sign-in', fill: 'currentcolor', height: 24),
      new_user_session_path,
      unless: -> { user_signed_in? },
      link_html: { class: "text-white nav-link pull-right" }
  end
end
