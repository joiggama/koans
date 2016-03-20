require_relative "sensei/color"

module Neo
  class Sensei
    attr_reader :failure, :failed_test, :pass_count

    FailedAssertionError = Assertions::FailedAssertionError

    def initialize
      @pass_count = 0
      @failure = nil
      @failed_test = nil
      @observations = []
    end

    PROGRESS_FILE_NAME = ".path_progress"

    def add_progress(prog)
      @_contents = nil
      exists = File.exists?(PROGRESS_FILE_NAME)
      File.open(PROGRESS_FILE_NAME,"a+") do |f|
        f.print "#{',' if exists}#{prog}"
      end
    end

    def progress
      if @_contents.nil?
        if File.exists?(PROGRESS_FILE_NAME)
          File.open(PROGRESS_FILE_NAME,"r") do |f|
            @_contents = f.read.to_s.gsub(/\s/,"").split(",")
          end
        else
          @_contents = []
        end
      end
      @_contents
    end

    def observe(step)
      if step.passed?
        @pass_count += 1
        if @pass_count > progress.last.to_i
          @observations << Color.green("#{step.koan_file}##{step.name} #{I18n.t("neo.sensei.your_awareness")}.")
        end
      else
        @failed_test = step
        @failure = step.failure
        add_progress(@pass_count)
        @observations << Color.red("#{step.koan_file}##{step.name} #{I18n.t("neo.sensei.your_karma")}.")
        throw :neo_exit
      end
    end

    def failed?
      ! @failure.nil?
    end

    def assert_failed?
      failure.is_a?(FailedAssertionError)
    end

    def instruct
      if failed?
        @observations.each{|c| puts c }
        encourage
        guide_through_error
        a_zenlike_statement
        show_progress
      else
        end_screen
      end
    end

    def show_progress
      bar_width = 50
      total_tests = Neo::Koan.total_tests
      scale = bar_width.to_f/total_tests
      print Color.green("#{I18n.t("neo.sensei.your_path")} [")
      happy_steps = (pass_count*scale).to_i
      happy_steps = 1 if happy_steps == 0 && pass_count > 0
      print Color.green("."*happy_steps)
      if failed?
        print Color.red("X")
        print Color.cyan("_"*(bar_width-1-happy_steps))
      end
      print Color.green("]")
      print " #{pass_count}/#{total_tests}"
      puts
    end

    def end_screen
      if Neo.simple_output
        boring_end_screen
      else
        artistic_end_screen
      end
    end

    def boring_end_screen
      puts I18n.t "neo.sensei.about_mountains_again"
    end

    def artistic_end_screen
      ruby_version = "(in #{'J' if defined?(JRUBY_VERSION)}Ruby #{defined?(JRUBY_VERSION) ? JRUBY_VERSION : RUBY_VERSION})"
      ascii_header = I18n.t("neo.sensei.about_mountains_again").center(48)
      ruby_version = ruby_version.center(48)
      completed = <<-ENDTEXT
                                  ,,   ,  ,,
                                :      ::::,    :::,
                   ,        ,,: :::::::::::::,,  ::::   :  ,
                 ,       ,,,   ,:::::::::::::::::::,  ,:  ,: ,,
            :,        ::,  , , :, ,::::::::::::::::::, :::  ,::::
           :   :    ::,                          ,:::::::: ::, ,::::
          ,     ,:::::                                  :,:::::::,::::,
      ,:     , ,:,,:                                       :::::::::::::
     ::,:   ,,:::,                                           ,::::::::::::,
    ,:::, :,,:::                                               ::::::::::::,
   ,::: :::::::,#{                ascii_header                 },::::::::::::
   :::,,,::::::                                                   ::::::::::::
 ,:::::::::::,                                                    ::::::::::::,
 :::::::::::,                                                     ,::::::::::::
:::::::::::::                                                     ,::::::::::::
::::::::::::    #{           "Ruby Koans".center(48)           }   ::::::::::::
::::::::::::    #{                ruby_version                 }  ,::::::::::::
:::::::::::,                                                      , :::::::::::
,:::::::::::::, #{  I18n.t("neo.sensei.about_who").center(48)  } ,,::::::::::::
::::::::::::::                                                    ,::::::::::::
 ::::::::::::::,                                                 ,:::::::::::::
 ::::::::::::,  #{      "Neo Software Artisans".center(48)     } , ::::::::::::
  :,::::::::: ::::                                               :::::::::::::
   ,:::::::::::  ,:                                          ,,:::::::::::::,
     ::::::::::::                                           ,::::::::::::::,
      :::::::::::::::::,                                  ::::::::::::::::
       :::::::::::::::::::,                             ::::::::::::::::
        ::::::::::::::::::::::,                     ,::::,:, , ::::,:::
          :::::::::::::::::::::::,               ::,: ::,::, ,,: ::::
              ,::::::::::::::::::::              ::,,  , ,,  ,::::
                 ,::::::::::::::::              ::,, ,   ,:::,
                      ,::::                         , ,,
                                                  ,,,
      ENDTEXT
      puts completed
    end

    def encourage
      puts
      puts "#{ I18n.t 'neo.sensei.the_master_says' }:"
      puts Color.cyan("  #{ I18n.t 'neo.sensei.your_enlightenment' }.")
      if ((recents = progress.last(5)) && recents.size == 5 && recents.uniq.size == 1)
        puts Color.cyan("  #{ I18n.t 'neo.sensei.your_frustration' }.")
      elsif progress.last(2).size == 2 && progress.last(2).uniq.size == 1
        puts Color.cyan("  #{ I18n.t 'neo.sensei.the_master_supports' }.")
      elsif progress.last.to_i > 0
        puts Color.cyan("  #{ I18n.t 'neo.sensei.your_progress', progress: progress.last }.")
      end
    end

    def guide_through_error
      puts
      puts "#{ I18n.t 'neo.sensei.your_answers' }..."
      puts Color.red(indent(failure.message).join)
      puts
      puts "#{I18n.t 'neo.sensei.the_master_instructs' }:"
      puts embolden_first_line_only(indent(find_interesting_lines(failure.backtrace)))
      puts
    end

    def embolden_first_line_only(text)
      first_line = true
      text.collect { |t|
        if first_line
          first_line = false
          Color.red(t)
        else
          Color.cyan(t)
        end
      }
    end

    def indent(text)
      text = text.split(/\n/) if text.is_a?(String)
      text.collect{|t| "  #{t}"}
    end

    def find_interesting_lines(backtrace)
      backtrace.reject { |line|
        line =~  %r{ lib/koans/neo }xi
      }
    end

    # Hat's tip to Ara T. Howard for the zen statements from his
    # metakoans Ruby Quiz (http://rubyquiz.com/quiz67.html)
    def a_zenlike_statement
      if !failed?
        zen_statement = I18n.t "neo.sensei.about_mountains_again"
      else
        zen_statement = case (@pass_count % 10)
        when 0
          I18n.t "neo.sensei.about_mountains"
        when 1, 2
          I18n.t "neo.sensei.about_rules"
        when 3, 4
          I18n.t "neo.sensei.about_silence"
        when 5, 6
          I18n.t "neo.sensei.about_sleep"
        when 7, 8
          I18n.t "neo.sensei.about_losing"
        else
          I18n.t "neo.sensei.about_things"
        end
      end
      puts Color.green(zen_statement)
    end
  end

end
