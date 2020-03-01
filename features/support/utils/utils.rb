# frozen_string_literal: true

# Получаем абсолютный путь к файлу
def get_filepath(filepath)
  filename = File.join(File.expand_path(Dir.pwd), filepath)
  unless File.file?(filename)
    puts "file #{filename} not finded"
    raise Errno::ENOENT
  end
  filename
end

# Передача файла на удаленную ноду селениума
def set_file_detector
  @browser.file_detector = lambda do |args|
    # args => ["/path/to/file"]
    str = args.first.to_s
    str if File.exist?(str)
  end
end

# Настройка параметров удаленного браузера
# опции старта, нода, тип
def setup_remote_browser
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      'chromeOptions' => { 'args' => %w(--disable-web-security --enable-features=NetworkService --ignore-certificate-errors )},
      #:version               => "60.0.3112.113",
      #:platform => 'LINUX',
      browserName: 'chrome',
  )
  hub_url = ENV['REMOTE_HUB']
  puts "http://#{hub_url}/wd/hub"
  @browser = Selenium::WebDriver.for(:remote, url: "http://#{hub_url}/wd/hub", desired_capabilities: caps)
end

# Выбираем локально или удаленно
def remote_or_local
  if !ENV['REMOTE_HUB'].nil?
    setup_remote_browser
    set_file_detector
  else

    prefs = {
        prompt_for_download: false,
        default_directory: 'path/to/dir'
    }
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_preference(:download, prefs)
    options.add_argument '--host-resolver-rules=MAP click.alfabank.ru 127.0.0.1'

    @browser = Selenium::WebDriver.for :chrome, options: options
    puts 1
  end
  setup_browser_properties
end

# Настройка драйвера (размер экрана, таймауты)
def setup_browser_properties
  #  puts @browser.manage.window.size
  target_size = Selenium::WebDriver::Dimension.new(1600, 1080)
  @browser.manage.window.size = target_size
  #  puts @browser.manage.window.size
  #  puts @browser.manage.timeouts
end

# Скриншот в конце каждого сценария, в папку report_files
def screenshot
  time = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
  filename = 'report_files/' + "error- #{time}.png"
  @browser.save_screenshot(filename)
  embed(filename, 'image/png')
end

# Выключаем браузер
def quit_browser
  @browser.quit
end

# Таймауты
def set_page_timeouts
  @browser.manage.timeouts.implicit_wait = 1 # 10
  @browser.manage.timeouts.script_timeout = 30 # 10
  @browser.manage.timeouts.page_load = 30
  @wait = Selenium::WebDriver::Wait.new(timeout: 30) # 10)
  #  puts @browser.manage.window.size
  target_size = Selenium::WebDriver::Dimension.new(1600, 1080)
  @browser.manage.window.size = target_size
  #  puts @browser.manage.window.size
  #  puts @browser.manage.timeouts
end